package com.shop.app.payment.controller;

import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.apache.http.HttpResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.service.CartService;
import com.shop.app.coupon.dto.MemberCouponDto;
import com.shop.app.coupon.entity.Coupon;
import com.shop.app.coupon.entity.MemberCoupon;
import com.shop.app.coupon.service.CouponService;
import com.shop.app.member.dto.MypageDto;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.entity.SubMember;
import com.shop.app.member.service.MemberService;
import com.shop.app.notification.service.NotificationService;
import com.shop.app.order.dto.OrderCreateDto;
import com.shop.app.order.entity.Order;
import com.shop.app.order.entity.OrderDetail;
import com.shop.app.order.service.OrderService;
import com.shop.app.payment.dto.PaymentCompleteNotificationDto;
import com.shop.app.payment.dto.SubScheduleDto;
import com.shop.app.payment.service.PaymentService;
import com.shop.app.payment.service.SchedulePay;
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
	
	@Autowired
	PaymentScheduler paymentScheduler;
	
	@Autowired
	SchedulePay schedulePay;
	
	@Autowired
	CouponService couponService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	NotificationService notificationService;
	
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

	/**
	 * 결제하기 (담희)
	 */
	@GetMapping("/paymentInfo.do")
	public void payment(Model model, Authentication authentication, @AuthenticationPrincipal MemberDetails member) {
		MemberDetails principal = (MemberDetails) authentication.getPrincipal();

		List<CartInfoDto> cartList = cartService.getCartInfoList(principal.getMemberId());
		Point point = pointService.findCurrentPointById(principal.getMemberId());

        MypageDto myPage = memberService.getMyPage(principal.getMemberId());
        int couponCount = myPage.getMemberCoupon();
        
        model.addAttribute("couponCount", couponCount);
		model.addAttribute("cartList", cartList);
		model.addAttribute("pointCurrent", point.getPointCurrent());

	}

	/**
	 * 결제 API 실행 전 주문 테이블에 먼저 주문 정보 insert 하기 위한 메소드 (담희)
	 */
	@ResponseBody
	@PostMapping("/proceed.do")
	public Map<String, Object> paymentProceed(@Valid @RequestBody OrderCreateDto _order) {
		Map<String, Object> resultMap = new HashMap<>();
		
		// 쿠폰 사용 여부 (예라)
		Boolean useCoupon = _order.getUseCoupon();
		log.debug("useCoupon = {}", _order.getUseCoupon());
		
		Order order = _order.toOder();

		List<OrderDetail> orderDetails = _order.getForms();

		// 0. 사용된 포인트 가져오기 (예라)
		int pointsUsed = _order.getPointsUsed();

		// 1. (사용) 현재 포인트를 가져오기
		Point points = new Point();
		points.setPointMemberId(_order.getMemberId());
		Point currentPoints = pointService.findPointCurrentById(points);
		
		if(pointsUsed != 0) {
		// 2. 포인트 사용 정보 저장
		Point usedPoint = new Point();
		usedPoint.setPointMemberId(_order.getMemberId());
		usedPoint.setPointType("구매사용");
		usedPoint.setPointAmount(-pointsUsed); // 사용된 포인트 금액

	    // 3. 사용된 포인트 업데이트
	    int currentPoint = currentPoints.getPointCurrent();
	    usedPoint.setPointCurrent(currentPoint - pointsUsed);

		// 4. db에 포인트 사용 정보 저장
		int usedPointResult = pointService.insertUsedPoint(usedPoint);
		
		}
		
		if (useCoupon) {
			// 1. 쿠폰 가져오기 (예라)
			
			int couponDiscount = _order.getCouponDiscount();
			
			log.debug("couponDiscount = {}", couponDiscount);
	
			MemberCoupon coupon = new MemberCoupon();
			coupon.setMemberId(_order.getMemberId());
			coupon.setCouponId(_order.getCouponId());
			coupon.setMemberCouponId(_order.getMemberCouponId());
			List<MemberCoupon> currentCoupons = couponService.findCouponCurrendById(coupon);
			
			// 2. 쿠폰 사용
			  
			// 2-1. 쿠폰 유효성 검사 
			List<MemberCoupon> validCoupons = couponService.validateCoupon(_order.getCouponId(), _order.getMemberId(), _order.getMemberCouponId());
	
			if (validCoupons != null && !validCoupons.isEmpty()) { // 유효한 쿠폰인 경우
			    MemberCoupon validCoupon = validCoupons.get(0); // 첫 번째 유효한 쿠폰을 선택
			    
			    // 2-2. 쿠폰 상태 업데이트 (사용됨)
			    validCoupon.setUseStatus(1);
			    int usedCouponResult = couponService.updateCouponStatus(validCoupon);
			    
			    order.setMemberCouponId(validCoupon.getMemberCouponId());
			} else {
				// 쿠폰을 사용하지 않을 경우 member_coupon_id 값을 null로 설정
				order.setMemberCouponId(null);
			}
		}
		  
		int result = orderService.insertOrder(order, orderDetails);

		String msg = "";

		if (result > 0) {
			msg = "주문에 성공하셨습니다.";

			// 0. 사용한 포인트가 0이면 적립하기 -> 포인트 사용하면 적립 안 되게 (예라)
			if (pointsUsed <= 0) {

				// 1. (적립) 결제 성공하면 구매한 금액의 1% 포인트 적립
				int amount = order.getAmount(); // 실제 주문 금액
				int pointAmount = (int) (amount * 0.01); // 주문 금액의 1% 적립

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

	/**
	 * 결제 검증 (담희)
	 */
	@PostMapping("/verifyIamport/{imp_uid}")
	@ResponseBody
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session,
			@PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException {
		return iamportClient.paymentByImpUid(imp_uid);
	}
	


	@PostMapping("/successPay.do")
	@ResponseBody
	public ResponseEntity<?> updatePayStatus(@RequestParam("merchant_uid") String merchantUid,
			@AuthenticationPrincipal MemberDetails member) {
		String orderNo = merchantUid;
		// payment 테이블에 삽입 및 orderTbl 상태 업데이트
		int result = paymentService.updatePayStatus(orderNo);
		return ResponseEntity.status(HttpStatus.OK).body(Map.of("result", 1));
	}

	@GetMapping("/paymentCompleted.do")
	public void paymentCompleted(@RequestParam String orderNo, Model model) {
		Order order = orderService.findOrderByOrderNo(orderNo);
		model.addAttribute("order", order);
		
		
		PaymentCompleteNotificationDto paymentCompleteNotificationDto = paymentService.notificationFindOrderByOrderNo(orderNo);
	    
		paymentCompleteNotificationDto = PaymentCompleteNotificationDto.builder()
	            .orderId(paymentCompleteNotificationDto.getOrderId())
	            .orderNo(paymentCompleteNotificationDto.getOrderNo())
	            .productName(paymentCompleteNotificationDto.getProductName())
	            .orderStatus(paymentCompleteNotificationDto.getOrderStatus())
	            .memberId(paymentCompleteNotificationDto.getMemberId())
	            .build();
		log.debug("paymentCompleteNotificationDto={}",paymentCompleteNotificationDto);
	    int result = notificationService.paymentCompleteNotification(paymentCompleteNotificationDto);
		
	}
	
//	@PostMapping("/paymentCompleted.do")
//	public void paymentCompleteNotification(@RequestParam String orderNo) {
//		
//		PaymentCompleteNotificationDto paymentCompleteNotificationDto = paymentService.notificationFindOrderByOrderNo(orderNo);
//	    
//		paymentCompleteNotificationDto = PaymentCompleteNotificationDto.builder()
//	            .orderId(paymentCompleteNotificationDto.getOrderId())
//	            .orderNo(paymentCompleteNotificationDto.getOrderNo())
//	            .productName(paymentCompleteNotificationDto.getProductName())
//	            .orderStatus(paymentCompleteNotificationDto.getOrderStatus())
//	            .memberId(paymentCompleteNotificationDto.getMemberId())
//	            .build();
//		log.debug("paymentCompleteNotificationDto={}",paymentCompleteNotificationDto);
//	    int result = notificationService.paymentCompleteNotification(paymentCompleteNotificationDto);
//	}
	
	/*
	 * 결제 취소를 확인하고 포인트 환불 처리하는 메소드 (예라)
	 */
	@PostMapping("/verifyAndHandleCancelledPayment/{imp_uid}")
	@ResponseBody
	public ResponseEntity<?> verifyAndHandleCancelledPayment(@Valid @RequestBody OrderCreateDto _order, 
			@PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException {

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

		if ("failed".equalsIgnoreCase(payment.getStatus())) {
		    // 4. 'failed' 상태라면 사용자의 포인트를 다시 반환
		    handleCancelledPayment(memberId, pointsUsed);

		    // 5. 쿠폰 환불 처리 추가
		    List<MemberCoupon> usedCoupons = couponService.findUsedCouponsByMemberId(memberId);
		    handleCancelledCouponRefund(usedCoupons);

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
		List<Point> currentPoints = pointService.findRollbackPointCurrentById(rollbackPoint);
		log.debug("currentPoints = {}", currentPoints);

		// 3. 현재 포인트에 반환될 포인트를 더한다
		int updatedPoint = currentPoints.get(0).getPointCurrent() + usedPoints;
		rollbackPoint.setPointCurrent(updatedPoint);

		// 4. 취소된 포인트를 db에 저장
		int pointRollback = pointService.insertRollbackPoint(rollbackPoint);
	}
	
	// 쿠폰 환불 처리 메소드
	private void handleCancelledCouponRefund(List<MemberCoupon> usedCoupons) {
	    for (MemberCoupon coupon : usedCoupons) {
	        
	        // 1. 쿠폰 사용 상태를 원래대로 변경 (use_status를 0으로, use_date를 null로)
	        coupon.setUseStatus(0); // 사용 안 함으로 변경
	        coupon.setUseDate(null); // 사용 날짜를 null로 설정
	        
	        // 2. 쿠폰 업데이트
	        int updateCoupon = couponService.updateCoupon(coupon); 
	    }
	}
	
	@ResponseBody
	@PostMapping("/startScheduler.do")
	public ResponseEntity<?> startMembership(@RequestBody SubScheduleDto subScheduleDto, RedirectAttributes redirectAttr) {
		
		String merchantUid = subScheduleDto.getMerchantUid();
		String customerUid = subScheduleDto.getCustomerUid();
		int amount = subScheduleDto.getAmount();
		
		// 회원 구독자 업데이트
		int memberUpdateResult = paymentService.insertSubPayment(customerUid);
		String result = schedulePay.schedulePay(merchantUid, customerUid, amount);
		
		return ResponseEntity.ok(result);
	}
	
	
	// 결제할 때 쿠폰 목록 보여주기 (예라)
	@GetMapping("/findCoupon.do")
    public ResponseEntity<?> getCoupons(Authentication authentication) {
        String memberId = authentication.getName();
        
        try {
            List<MemberCouponDto> coupons = couponService.findCouponsByMemberId(memberId);
            log.debug("coupons = {}", coupons);
            if (coupons.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
                
            }
            return new ResponseEntity<>(coupons, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>( HttpStatus.INTERNAL_SERVER_ERROR);
        }
        
        
    }
}