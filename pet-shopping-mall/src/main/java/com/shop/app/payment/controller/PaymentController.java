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
import com.shop.app.cart.dto.PurchaseDto;
import com.shop.app.cart.service.CartService;
import com.shop.app.coupon.dto.MemberCouponDto;
import com.shop.app.coupon.entity.Coupon;
import com.shop.app.coupon.entity.MemberCoupon;
import com.shop.app.coupon.service.CouponService;
import com.shop.app.member.dto.MypageDto;
import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.entity.SubMember;
import com.shop.app.member.entity.Subscribe;
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
	 * @author 김담희
	 * 구매 요청 페이지 조회
	 * 장바구니에서 요청이 넘어올 시, 장바구니에 있는 상품 구매 페이지로 넘어감
	 * 상품 상세 페이지에서 요청이 넘어올 시, 해당 상품의 옵션 값과 수량에 대해서 구매 페이지로 넘어감
	 */
	@GetMapping("/paymentInfo.do")
	public void payment(Model model, Authentication authentication, @AuthenticationPrincipal MemberDetails member, @RequestParam(required=false) Integer productDetailId, @RequestParam(required=false) Integer quantity) {
		MemberDetails principal = (MemberDetails) authentication.getPrincipal();
		
		if(productDetailId != null) {
			PurchaseDto purchaseOne = cartService.paymentOneInfo(productDetailId);
			purchaseOne.setQuantity(quantity);
			model.addAttribute("purchaseOne", purchaseOne);
			
		} else {
			List<CartInfoDto> cartList = cartService.getCartInfoList(principal.getMemberId());
			model.addAttribute("cartList", cartList);
		}
		
		Point point = pointService.findCurrentPointById(principal.getMemberId());
        MypageDto myPage = memberService.getMyPage(principal.getMemberId());
        int couponCount = myPage.getMemberCoupon();
        
        model.addAttribute("myPage", myPage);
        model.addAttribute("couponCount", couponCount);
		model.addAttribute("pointCurrent", point.getPointCurrent());
	}
	
	
	/**
	 * @author 김담희
	 * 상품 상세페이지에서 hidden 폼에 넣어서 구매 요청을 보내기 때문에 POST로 받은 값을
	 * GET으로 변환해서 넘김
	 */
	@PostMapping("/paymentInfo.do")
	public String paymentOne(Authentication authentication, @AuthenticationPrincipal MemberDetails member, @RequestParam int quantity, @RequestParam int productDetailId, RedirectAttributes redirectAttr) {
		return "redirect:/payment/paymentInfo.do?productDetailId="+productDetailId+"&quantity="+quantity;
	}
	
	

	/**
	 * @author 김담희
	 * 결제 API 실행 전 주문 테이블과 주문 상세 테이블에 먼저 주문 정보 insert
	 * (결제 취소 요청이 들어오거나 실패 시, 바로 delete 처리함)
	 * 
	 * @author 전예라
	 * 포인트/쿠폰 사용과 포인트 적립(일반 1% / 구독자 3%, 포인트 사용하면 적립 안됨)
	 */
	@ResponseBody
	@PostMapping("/proceed.do")
	public Map<String, Object> paymentProceed(@Valid @RequestBody OrderCreateDto _order) {
		Map<String, Object> resultMap = new HashMap<>();
		
		Boolean useCoupon = _order.getUseCoupon();
		Order order = _order.toOder();

		List<OrderDetail> orderDetails = _order.getForms();

		int pointsUsed = _order.getPointsUsed();

		Point points = new Point();
		points.setPointMemberId(_order.getMemberId());
		Point currentPoints = pointService.findPointCurrentById(points);
		
		if(pointsUsed != 0) {

		Point usedPoint = new Point();
		usedPoint.setPointMemberId(_order.getMemberId());
		usedPoint.setPointType("구매사용");
		usedPoint.setPointAmount(-pointsUsed);

	    int currentPoint = currentPoints.getPointCurrent();
	    usedPoint.setPointCurrent(currentPoint - pointsUsed);

		int usedPointResult = pointService.insertUsedPoint(usedPoint);
		
		}
		
		if (useCoupon) {
			
			int couponDiscount = _order.getCouponDiscount();
	
			MemberCoupon coupon = new MemberCoupon();
			coupon.setMemberId(_order.getMemberId());
			coupon.setCouponId(_order.getCouponId());
			coupon.setMemberCouponId(_order.getMemberCouponId());
			List<MemberCoupon> currentCoupons = couponService.findCouponCurrendById(coupon);
			List<MemberCoupon> validCoupons = couponService.validateCoupon(_order.getCouponId(), 
												_order.getMemberId(), _order.getMemberCouponId());
	
			if (validCoupons != null && !validCoupons.isEmpty()) { 
			    MemberCoupon validCoupon = validCoupons.get(0); 
			    validCoupon.setUseStatus(1);
			    int usedCouponResult = couponService.updateCouponStatus(validCoupon);
			    
			    order.setMemberCouponId(validCoupon.getMemberCouponId());
			} else {
				order.setMemberCouponId(null);
			}
		}
		  
		int result = orderService.insertOrder(order, orderDetails);

		String msg = "";

		if (result > 0) {
			msg = "주문에 성공하셨습니다.";

			if (pointsUsed <= 0) {

			    Member subscribeMember = memberService.findMemberById(order.getMemberId());
			    boolean subscriber = (subscribeMember.getSubscribe() == Subscribe.Y);
			    
				int amount = order.getAmount();
				double pointRate  = subscriber ? 0.03 : 0.01;
				int pointAmount = (int) (amount * pointRate);

				Point point = new Point();
				point.setPointMemberId(order.getMemberId());
				point.setPointType("구매적립");
				point.setPointAmount(pointAmount);

				Point currentPoints2 = pointService.findReviewPointCurrentById(point);

				int updatedPointAmount = currentPoints.getPointCurrent() + pointAmount;

				point.setPointCurrent(updatedPointAmount);

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
	 * @author 김담희
	 * 아임포트 서버에서 결제 검증
	 */
	@PostMapping("/verifyIamport/{imp_uid}")
	@ResponseBody
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session,
			@PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException {
		return iamportClient.paymentByImpUid(imp_uid);
	}

	
	/**
	 * @author 김담희
	 * 결제 성공 시 결제 내역 테이블 저장, 주문 테이블에 결제 방법 및 결제 완료 여부 업데이트
	 */
	@PostMapping("/successPay.do")
	@ResponseBody
	public ResponseEntity<?> updatePayStatus(@RequestParam("merchant_uid") String merchantUid,
			@AuthenticationPrincipal MemberDetails member, @RequestParam("pg_provider") String pgProvider) {
		String orderNo = merchantUid;
		int result = paymentService.updatePayStatus(orderNo, pgProvider);
		return ResponseEntity.status(HttpStatus.OK).body(Map.of("result", 1));
	}
	

	/**
	 * @author 김담희
	 * 결제가 완료 처리되면 결제 완료 페이지로 매핑
	 */
	@GetMapping("/paymentCompleted.do")
	public void paymentCompleted(@RequestParam String orderNo, Model model) {
		Order order = orderService.findOrderByOrderNo(orderNo);
		model.addAttribute("order", order);
	}

	/**
	 * @author 전예라
	 * 결제 중에 취소했을 때 사용했던 포인트, 쿠폰을 롤백 처리하는 메소드
	 */
	@PostMapping("/verifyAndHandleCancelledPayment/{imp_uid}")
	@ResponseBody
	public ResponseEntity<?> verifyAndHandleCancelledPayment(@Valid @RequestBody OrderCreateDto _order, 
			@PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException {

		IamportResponse<Payment> paymentResponse = iamportClient.paymentByImpUid(imp_uid);

		if (paymentResponse == null || paymentResponse.getResponse() == null) {
			return ResponseEntity.badRequest().body("결제 정보를 가져올 수 없습니다.");
		}

		Payment payment = paymentResponse.getResponse();
		String orderUid = payment.getMerchantUid();

		Order order = _order.toOder();

		Order findOrder = orderService.findByOrder(order);

		String memberId = _order.getMemberId();
		int pointsUsed = findOrder.getDiscount();

		if ("failed".equalsIgnoreCase(payment.getStatus())) {
		    handleCancelledPayment(memberId, pointsUsed);

		    List<MemberCoupon> usedCoupons = couponService.findUsedCouponsByMemberId(memberId);
		    handleCancelledCouponRefund(usedCoupons);

		    return ResponseEntity.ok("결제가 취소되었습니다.");
		}

		return ResponseEntity.ok(paymentResponse);
	}

	// 포인트 환불 처리 메소드
	private void handleCancelledPayment(String memberId, int usedPoints) {
		
	    Point rollbackPoint = new Point();
	    rollbackPoint.setPointMemberId(memberId);
	    rollbackPoint.setPointType("구매취소");
	    rollbackPoint.setPointAmount(usedPoints);

	    Point currentPoints = pointService.findPointCurrentById(rollbackPoint);

	    int currentPoint = currentPoints.getPointCurrent(); // 현재 포인트
	    int earnedPoint = currentPoints.getPointAmount(); // 적립된 금액
	    int netPoint = currentPoint - earnedPoint; // 적립된 금액을 제외한 실제 포인트

	    rollbackPoint.setPointCurrent(netPoint);

	    int pointRollback = pointService.insertRollbackPoint(rollbackPoint);

	}
	
	// 쿠폰 환불 처리 메소드
	private void handleCancelledCouponRefund(List<MemberCoupon> usedCoupons) {
	    for (MemberCoupon coupon : usedCoupons) {
	        
	        coupon.setUseStatus(0);
	        coupon.setUseDate(null);
	  
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
	
	
	@GetMapping("/findCoupon.do")
    public ResponseEntity<?> getCoupons(Authentication authentication) {
        String memberId = authentication.getName();
        
        try {
            List<MemberCouponDto> coupons = couponService.findCouponsByMemberId(memberId);
            if (coupons.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
                
            }
            return new ResponseEntity<>(coupons, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>( HttpStatus.INTERNAL_SERVER_ERROR);
        }
        
        
    }
	
	
	/**
	 * @author 김담희
	 * 구독 해지
	 * customerUid(회원 아이디)로 sub_member 조회를 해서 그 정보를 바탕으로 구독 해지 처리
	 */
	@PostMapping("/unsubscribe.do")
	public String unsubscribe (@RequestParam String customerUid, RedirectAttributes redirectAttr) {
		SubMember subMember = memberService.findSubMemberByMemberId(customerUid);
		String result = schedulePay.cancelSchedule(subMember);
		
		redirectAttr.addFlashAttribute("msg", "구독이 해제되었습니다.");
		return "redirect:/member/myPage.do";
	}
}