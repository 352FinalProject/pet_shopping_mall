package com.shop.app.payment.controller;


import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.taglibs.standard.lang.jstl.NamedValue;
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
import org.apache.http.HttpResponse;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.dto.CartListDto;
import com.shop.app.cart.service.CartService;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.order.dto.OrderCreateDto;
import com.shop.app.order.entity.Order;
import com.shop.app.order.entity.OrderDetail;
import com.shop.app.order.service.OrderService;
import com.shop.app.payment.service.PaymentService;
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
	PaymentService paymentService;
	
	@Autowired
	PointService pointService;

	private IamportClient iamportClient;
	private IamportApi iamportApi;
	public static final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken";
	public static final String IMPORT_CANCEL_URL = "https://api.iamport.kr/payments/cancel";

	public PaymentController(IamportApi api) {
		this.iamportApi = api;
		String IMP_API = api.getApiKey();
		String IMP_SECRET = api.getApiSecret();
		this.iamportClient = new IamportClient(IMP_API, IMP_SECRET);
	}


	@GetMapping("/paymentInfo.do")
	public void payment(Model model, Authentication authentication, @AuthenticationPrincipal MemberDetails member) {
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
		
		List<OrderDetail> orderDetails= _order.getForms();
		
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

		int result = orderService.insertOrder(order, orderDetails);

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
		return iamportClient.paymentByImpUid(imp_uid);
	}
	
	
	
	
	
	@PostMapping("/successPay.do")
	@ResponseBody
	public ResponseEntity<?> updatePayStatus(@RequestParam("merchant_uid") String merchantUid, @AuthenticationPrincipal MemberDetails member) {
		String orderNo = merchantUid;
		// payment 테이블에 삽입 및 orderTbl 상태 업데이트
		int result = paymentService.updatePayStatus(orderNo);
		return ResponseEntity
				.status(HttpStatus.OK)
				.body(Map.of("result", 1));
	}
	
	
	@GetMapping("/paymentCompleted.do")
	public void paymentCompleted(@RequestParam String orderNo, Model model) {
		Order order = orderService.findOrderByOrderNo(orderNo);
		model.addAttribute("order", order);
	}
	
	
	/*
	 * 결제 취소를 확인하고 포인트 환불 처리하는 메소드 (예라)
	 * */
	@PostMapping("/verifyAndHandleCancelledPayment/{imp_uid}")
	@ResponseBody
	public ResponseEntity<?> verifyAndHandleCancelledPayment(@Valid @RequestBody OrderCreateDto _order, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException {
	    
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

	    String memberId = _order.getMemberId();
		int pointsUsed = findOrder.getDiscount();
	    
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
	}
	
	
	
	@PostMapping("/refundOrder.do")
	public String refundOrder(@RequestParam String orderNo, RedirectAttributes redirectAttr, @RequestParam String isRefund) {
		String token = getImportToken();
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_CANCEL_URL);
		Map<String, String> map = new HashMap<>();
		
        post.setHeader("Authorization", token); 
        map.put("merchant_uid", orderNo); 
        String result = "";
        try { 
            post.setEntity(new UrlEncodedFormEntity(convertParameter(map))); 
            HttpResponse res = client.execute(post); 
            ObjectMapper mapper = new ObjectMapper(); 
            String enty = EntityUtils.toString(res.getEntity()); 
            JsonNode rootNode = mapper.readTree(enty); result = rootNode.get("response").asText();
        } catch (Exception e) { 
            e.printStackTrace(); 
        } 
        
        if (result.equals("null")) { 
        	redirectAttr.addFlashAttribute("msg", "환불 실패");
        	return "redirect:/order/orderList.do";
        } else { 
        	orderService.insertCancelOrder(orderNo, isRefund);
        	redirectAttr.addFlashAttribute("msg", "환불 성공");
        	return "redirect:/order/orderList.do";
        }
	}
	
	
	
	/**
	 * 아임포트 토큰을 받아오는 함수
	 */
	public String getImportToken() {
		String result = "";
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_TOKEN_URL);
		Map<String, String> map = new HashMap<>();
		
		
		map.put("imp_key", iamportApi.getApiKey());
	    map.put("imp_secret", iamportApi.getApiSecret());
		
	    try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(map)));
			HttpResponse response = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			
			String body = EntityUtils.toString(response.getEntity());
			JsonNode rootNode = mapper.readTree(body);
			log.debug("rootNode = {}", rootNode);
			JsonNode resNode =  rootNode.get("response");
			log.debug("resNode = {}", resNode);
			 result = resNode.get("access_token").asText(); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	/**
	 * Map을 List<NameValuePair>으로 형변환하는 메소드 (담희)
	 */
	public List<NameValuePair> convertParameter(Map<String, String> paramMap) {
		List<NameValuePair> params = new ArrayList<>();
		for(Map.Entry<String, String> entry : paramMap.entrySet()) {
			params.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
		}
		return params;
	}
}