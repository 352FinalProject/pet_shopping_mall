package com.shop.app.payment.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
	    log.debug("_order = {}", _order);
	    Order order = _order.toOder();
	    order.setDiscountCode("포인트사용"); // 할인 코드 설정 (예라)
	    
	    // 포인트를 사용하는 경우 (예라)
	    if(_order.isUsePoints) {
	        int discountAmount = calculateDiscount(_order.getPointsUsed());
	        _order.setDiscount(_order.getDiscount() + discountAmount); // 주문의 할인 금액에 포인트 할인 금액 반영
	    }
	    
	    int result = orderService.insertOrder(order);
	    log.debug("result = {}", result);
	    
	    String msg = "";
	    
	    if(result > 0) {
	    	msg = "주문에 성공하셨습니다.";
	    	
	    // 1. 결제 성공하면 구매한 금액의 1% 포인트 적립 (예라)
	    int amount = order.getAmount(); // 실제 주문 금액
	    int pointAmount = (int)(amount * 0.01); // 주문 금액의 1% 적립
	    
	    Point point = new Point();
	    point.setPointMemberId(order.getMemberId());
	    point.setPointType("구매적립"); // 포인트 유형
	    point.setPointAmount(pointAmount); // 적립된 포인트
	      
	    // 3. memberId값으로 현재 사용자의 포인트 가져오기 (예라)
	    Point currentPoints = pointService.findReviewPointCurrentById(point); 
	    log.debug("currentPoints = {}", currentPoints);
	    
	    // 4. 현재 포인트를 가져온 후 포인트 적립 계산
	    int updatedPointAmount = currentPoints.getPointCurrent() + pointAmount;
	    
	    // 5. 업데이트된 포인트 값 설정
	    point.setPointCurrent(updatedPointAmount);
	    
	    // 6. 적립된 포인트를 DB에 저장
	    int pointResult = pointService.insertPoint(point);
	    
		} else 
	    	msg = "주문에 실패하셨습니다. 관리자에게 문의하세요.";	
	    	
	    resultMap.put("result", result);
	    resultMap.put("msg", msg);
	    
	    return resultMap;
	}
	
	// 할인율 계산하는 메소드 (예
	private int calculateDiscount(int pointsUsed) {
		return pointsUsed;
	}


	@PostMapping("/verifyIamport/{imp_uid}")
	@ResponseBody
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session
									, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException{
		log.debug("imp_uid= {}", imp_uid);
		return iamportClient.paymentByImpUid(imp_uid);
	}
	
}