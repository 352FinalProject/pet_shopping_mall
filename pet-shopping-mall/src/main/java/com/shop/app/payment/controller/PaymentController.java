package com.shop.app.payment.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.dto.CartListDto;
import com.shop.app.cart.service.CartService;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.order.dto.OrderCreateDto;
import com.shop.app.order.entity.Order;
import com.shop.app.order.service.OrderService;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/payment")
@Controller
public class PaymentController {

	@Autowired
	OrderService orderService;

	@Autowired
	CartService cartService;

	@Autowired
	PointService pointService;

	private IamportClient iamportClient;
	private IamportApi IamportApi;


	public PaymentController(IamportApi api) {
		this.IamportApi = api;
		String IMP_API = api.getApiKey();
		log.debug("IMP_API = {}" , IMP_API);
		String IMP_SECRET = api.getApiSecret();
		this.iamportClient = new IamportClient(IMP_API, IMP_SECRET);
	}


	@GetMapping("/paymentInfo.do")
	public void payment(Model model, Authentication authentication, @AuthenticationPrincipal MemberDetails member) {
		// 폼으로 가져오기
		MemberDetails principal = (MemberDetails) authentication.getPrincipal();
		List<CartInfoDto> cartList = cartService.getCartInfoList(principal.getMemberId());

		Point point = pointService.findCurrentPointById(principal.getMemberId());

		model.addAttribute("cartList", cartList);
		model.addAttribute("pointCurrent", point.getPointCurrent());

	}

	/**
	 * 결제 API 실행 전 주문 테이블에 먼저 주문 정보 insert 하기 위한 메소드
	 */
	@ResponseBody
	@PostMapping("/proceed.do")
	public Map<String, Object> paymentProceed(@Valid @RequestBody OrderCreateDto _order) {
		Map <String, Object> resultMap = new HashMap<>();
		Order order = _order.toOder();

		// 0. 사용된 포인트 가져오기 (예라)
		int pointsUsed = _order.getPointsUsed();
		log.debug("사용 포인트 pointsUsed = {}", pointsUsed);

		// 1. (사용) 현재 포인트를 가져오기
		Point points = new Point();
		points.setPointMemberId(_order.getMemberId());
		Point currentPoints = pointService.findPointCurrentById(points);

		// 2. 포인트 사용 정보 저장
		Point usedPoint = new Point();
		usedPoint.setPointMemberId(_order.getMemberId());
		usedPoint.setPointType("구매사용"); 
		usedPoint.setPointAmount(-_order.getPointsUsed()); // 사용된 포인트 금액

		// 3. 사용된 포인트 업데이트
		int currentPoint = currentPoints.getPointCurrent();
		usedPoint.setPointCurrent(currentPoint - _order.getPointsUsed());

		// 4. db에 포인트 사용 정보 저장
		int usedPointResult = pointService.insertUsedPoint(usedPoint);

		int result = orderService.insertOrder(order);

		String msg = "";

		if(result > 0) {
			msg = "주문에 성공하셨습니다.";

			// 0. 사용한 포인트가 0이면 적립하기 -> 포인트 사용하면 적립 안 되게 (예라)
			if(pointsUsed <= 0) {

				// 1. (적립) 결제 성공하면 구매한 금액의 1% 포인트 적립
				int amount = order.getAmount(); // 실제 주문 금액
				int pointAmount = (int)(amount * 0.01); // 주문 금액의 1% 적립
				
				// 2. 적립할 포인트 정보 저장
				Point point = new Point();
				point.setPointMemberId(order.getMemberId());
				point.setPointType("구매적립"); // 포인트 유형
				point.setPointAmount(pointAmount); // 적립된 포인트

				// 3. memberId값으로 현재 사용자의 포인트 가져오기
				Point currentPoints2 = pointService.findReviewPointCurrentById(point); 

				// 4. 현재 포인트를 가져온 후 포인트 적립 계산
				int updatedPointAmount = currentPoints.getPointCurrent() + pointAmount;

				// 5. 업데이트된 포인트 값 설정
				point.setPointCurrent(updatedPointAmount);

				// 6. 적립된 포인트를 db에 저장
				int pointResult = pointService.insertPoint(point);
				}
			
			} else {
				msg = "주문에 실패하셨습니다. 관리자에게 문의하세요.";	
			}
		
			resultMap.put("result", result);
			resultMap.put("msg", msg);

			return resultMap;
		}


	@PostMapping("/verifyIamport/{imp_uid}")
	@ResponseBody
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session
			, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException{
		log.debug("imp_uid= {}", imp_uid);
		return iamportClient.paymentByImpUid(imp_uid);
	}
	
	
	@PostMapping("/successPay.do")
	@ResponseBody
	public ResponseEntity<?> updatePayStatus(@RequestParam("merchant_uid") String merchantUid, @AuthenticationPrincipal MemberDetails member) {
		String orderNo = merchantUid;
		int result = cartService.updatePayStatus(orderNo);
		
		// 주문이 완료되면 장바구니 전체 비우기
		String memberId = member.getMemberId();
		 int deleteCart = cartService.deleteCartAll(memberId);
		
		return ResponseEntity
				.status(HttpStatus.OK)
				.body(Map.of("result", 1));
	}
	
	
	@GetMapping("/paymentCompleted.do")
	public void paymentCompleted() {}
	
	/*
	 * 결제 취소를 확인하고 포인트 환불 처리하는 메소드 (예라)
	 * */
	@PostMapping("/verifyAndHandleCancelledPayment/{imp_uid}")
	@ResponseBody
	public ResponseEntity<?> verifyAndHandleCancelledPayment(@Valid @RequestBody OrderCreateDto _order, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException {
	    log.debug("imp_uid_rollback = {}", imp_uid);
	    
	    // 1. 결제 정보 가져오기
	    IamportResponse<Payment> paymentResponse = iamportClient.paymentByImpUid(imp_uid);

	    if (paymentResponse == null || paymentResponse.getResponse() == null) {
	        return ResponseEntity.badRequest().body("결제 정보를 가져올 수 없습니다.");
	    }

	    Payment payment = paymentResponse.getResponse();
	    String orderUid = payment.getMerchantUid();
	    
		Order order = _order.toOder();
	    
	    // 2. db에서 주문 정보 가져오기
	    Order findOrder = orderService.findByOrder(order);
	    log.debug("findOrder = {}", findOrder);

	    String memberId = _order.getMemberId();
		int pointsUsed = findOrder.getDiscount();
	    
	    log.debug("_order = {}", _order);
	    log.debug("pointsUsed = {}", pointsUsed);
	    
	    // 3. 결제 상태가 'failed'인지 확인
	    if ("failed".equalsIgnoreCase(payment.getStatus())) {
	        // 4. 'failed' 상태라면 사용자의 포인트를 다시 반환
	        handleCancelledPayment(memberId, pointsUsed);
	        return ResponseEntity.ok("결제가 취소되었으며 포인트가 환불되었습니다.");
	    }

	    return ResponseEntity.ok(paymentResponse);
	}

	private void handleCancelledPayment(String memberId, int usedPoints) {
	    // 1. 포인트 반환 로직
	    Point rollbackPoint = new Point();
	    rollbackPoint.setPointMemberId(memberId);
	    rollbackPoint.setPointType("구매취소");
	    rollbackPoint.setPointAmount(usedPoints);

	    // 2. 현재 포인트 값을 가져온다
	    Point currentPoints = pointService.findPointCurrentById(rollbackPoint);
	    log.debug("currentPoints = {}", currentPoints);

	    // 3. 현재 포인트에 반환될 포인트를 더한다
	    int updatedPoint = currentPoints.getPointCurrent() + usedPoints;
	    rollbackPoint.setPointCurrent(updatedPoint);

	    // 4. 취소된 포인트를 db에 저장
	    int pointRollback = pointService.insertRollbackPoint(rollbackPoint);
	    log.debug("pointRollback = {}", pointRollback);
	}
}