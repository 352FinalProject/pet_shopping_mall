package com.shop.app.member.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.coupon.entity.Coupon;
import com.shop.app.coupon.entity.MemberCoupon;
import com.shop.app.coupon.service.CouponService;
import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.dto.MemberUpdateDto;
import com.shop.app.member.dto.MypageDto;
import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.entity.TermsHistory;
import com.shop.app.member.service.MemberService;
import com.shop.app.notification.entity.Notification;
import com.shop.app.notification.repository.NotificationRepository;
import com.shop.app.order.service.OrderService;
import com.shop.app.payment.dto.SubScheduleDto;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;
import com.shop.app.terms.entity.Accept;
import com.shop.app.terms.entity.Terms;
import com.shop.app.terms.service.TermsService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@Validated
@RequestMapping("/member")
public class MemberSecurityController {

   @Autowired // MemberService 자동 주입
   private MemberService memberService;

   @Autowired // 비밀번호 암호화 도구 자동 주입
   private PasswordEncoder passwordEncoder;

   @Autowired
   private PointService pointService;

   @Autowired
   private TermsService termsService;
   
   @Autowired
   private CouponService couponService;
   
   @Autowired
   private OrderService orderService;

   @Autowired
	NotificationRepository notificationRepository; // 알림 레파
	
	@Autowired
	SimpMessagingTemplate simpMessagingTemplate; // 알림

   
   @GetMapping("/memberCreate.do") // 회원 생성 페이지로 이동하는 맵핑
   public void memberCreate() {
   }

   private final Map<String, String> tokenStore = new HashMap<>();

   Map<Integer, Accept> userAgreements = new HashMap<>();

   
   /**
    * @author 김상훈
    * 회원가입 (비밀번호 암호화 처리)
    * 
    * @author 전예라
    * 이메일 인증 api, 회원가입 포인트 지급, 회원가입 쿠폰 발급, 이용약관 처리
    * 
    * @author 김대원
    * 회원가입 쿠폰이 발급되면 회원에게 알림 발송
    */
   @PostMapping("/memberCreate.do")
   public String memberCreate(@Valid MemberCreateDto member, BindingResult bindingResult,
         RedirectAttributes redirectAttr, HttpSession session) {

      Boolean isVerified = (Boolean) session.getAttribute("emailVerified");
      if (isVerified == null || !isVerified) {
         redirectAttr.addFlashAttribute("msg", "이메일 인증을 해주세요.");
         return "redirect:/member/memberCreate.do";
      }

      if (bindingResult.hasErrors()) {
         ObjectError error = bindingResult.getAllErrors().get(0);
         redirectAttr.addFlashAttribute("msg", error.getDefaultMessage());
         return "redirect:/member/memberCreate.do";
      }

      String rawPassword = member.getPassword();
      String encodedPassword = passwordEncoder.encode(rawPassword);
      member.setPassword(encodedPassword);

      int result = memberService.insertMember(member);

      Point point = new Point();
      point.setPointMemberId(member.getMemberId());
      point.setPointCurrent(3000);
      point.setPointType("회원가입");
      point.setPointAmount(3000);
      
      int resultPoint = pointService.insertPoint(point);
      
       List<Coupon> resultCoupon = couponService.findCoupon();
       for (Coupon coupon : resultCoupon) {
           MemberCoupon memberCoupon = new MemberCoupon();
           memberCoupon.setCouponId(coupon.getCouponId());
           memberCoupon.setMemberId(member.getMemberId());

           LocalDateTime issuanceDate = LocalDateTime.now();
           LocalDateTime endDate = issuanceDate.plusMonths(1);
           
           memberCoupon.setCreateDate(issuanceDate); 
           memberCoupon.setEndDate(endDate); 
           memberCoupon.setUseStatus(0);

           int memberInsertCoupon = couponService.insertDeliveryCoupon(memberCoupon);
           
           String to = memberCoupon.getMemberId();
			Notification insertNotification = Notification.builder()
					.notiCategory(3)
					.notiContent("회원가입 배송비 할인 쿠폰이 발급됐습니다.")
					.notiCreatedAt(formatTimestampNow())
					.memberId(to) 
					.build();
			
			notificationRepository.insertNotification(insertNotification);
			Notification notification = notificationRepository.latestNotification();
			simpMessagingTemplate.convertAndSend("/pet/notice/" + to, notification);
           
       }
      
       Object obj = session.getAttribute("userAgreements");
       Terms terms = new Terms();

      if (obj instanceof HashMap) {
         HashMap<Integer, Accept> userAgreements = (HashMap<Integer, Accept>) obj;

         terms.setMemberId(member.getMemberId());

         List<TermsHistory> findTermsHistory = termsService.fineTermsHistory();


         for (TermsHistory th : findTermsHistory) {
            terms.setHistoryId(th.getTermsId());
            terms.setTermsId(th.getTermsId());
            terms.setAccept(userAgreements.getOrDefault(th.getTermsId(), Accept.N));

            int result2 = termsService.insertTerms(terms);
         }

         session.removeAttribute("terms");

      } else {
         redirectAttr.addFlashAttribute("msg", "약관에 동의해주세요.");
         return "redirect:/member/terms.do";
      }
      session.removeAttribute("emailVerified");

      return "redirect:/member/memberCreateComplete.do";
   }
   
   /**
    * @author 전예라
    * 회원이 체크한 Y/N을 임시 세션에 저장
    */
   @PostMapping("/updateTerms.do")
   public ResponseEntity<?> updateTerms(@RequestParam Map<String, String> data, HttpSession session) {

      String term = data.get("termsAccept");
      String privacy = data.get("privacyAccept");
      String promotion = data.get("emailAccept");

      userAgreements.put(1, "Y".equals(term) ? Accept.Y : Accept.N);
      userAgreements.put(2, "Y".equals(privacy) ? Accept.Y : Accept.N);
      userAgreements.put(3, "Y".equals(promotion) ? Accept.Y : Accept.N);

      session.setAttribute("userAgreements", userAgreements);

      return new ResponseEntity<>(HttpStatus.OK);
   }
      
   @GetMapping("/memberLogin.do")
   public void memberLogin() {}
     
   @GetMapping("/updateMember.do")
   public void memberDetail(Authentication authentication, 
         @AuthenticationPrincipal MemberDetails _member, 
         Model model) { 

		MemberDetails principal = (MemberDetails) authentication.getPrincipal();
		Object credentials = authentication.getCredentials();
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

		Member member = memberService.findMemberById(_member.getMemberId());
		
		model.addAttribute("member", member);
   }
   
   
   /**
    * @author 김담희
    * 마이 페이지에서 최근 1개월간 주문 내역 및 구독 정보 등 조회
    */
   @GetMapping("/myPage.do")
   public void myPage(Model model, @AuthenticationPrincipal MemberDetails member, @RequestParam(defaultValue = "1") int page) {
      String memberId = member.getMemberId();
      int limit = 5;
      Map<String, Object> params = Map.of(
    		  "page", page,
    		  "limit", limit
    		  );
      int totalCount = orderService.findTotalOrderCount(memberId);
      int totalPages = (int) Math.ceil((double) totalCount / limit);
      model.addAttribute("totalPages", totalPages);
      
      MypageDto myPage = memberService.getMyPage(memberId, params);
      
      int couponCount = myPage.getMemberCoupon();
  
      model.addAttribute("myPage", myPage);
      model.addAttribute("member", member);
      model.addAttribute("couponCount", couponCount);
   }

   @PostMapping("/updateMember.do")
   public String memberUpdate(@AuthenticationPrincipal MemberDetails principal,
         @Valid MemberUpdateDto _member, HttpSession session, BindingResult bindingResult,
         RedirectAttributes redirectAttr, Model model) {
      Member member = _member.toMember();
      String memberId = principal.getMemberId();
      member.setMemberId(memberId);
      
      
      if (_member.getPassword() != null && !_member.getPassword().isEmpty()) {
         String rawPassword = _member.getPassword();
         String encodedPassword = passwordEncoder.encode(rawPassword);
         member.setPassword(encodedPassword);
      }
      
      int result = memberService.updateMember(member);

      
      UserDetails memberDetails = memberService.loadUserByUsername(memberId);
      Authentication newAuthentication = new UsernamePasswordAuthenticationToken(memberDetails,
            memberDetails.getPassword(), memberDetails.getAuthorities());
      SecurityContextHolder.getContext().setAuthentication(newAuthentication);
      session.invalidate(); 
      redirectAttr.addFlashAttribute("msg", "회원정보를 성공적으로 수정했습니다.🎁");
      return "redirect:/member/updateMember.do";
   }
   
   

   @PostMapping("/deleteMember.do")
   public String deleteMember(@AuthenticationPrincipal MemberDetails principal, RedirectAttributes redirectAttr,
         HttpSession session) {
      String memberId = principal.getMemberId();
      memberService.deleteMember(memberId); // 회원 삭제 서비스 호출
      session.invalidate(); // 세션 종료

      return "redirect:/"; // 로그아웃 후 메인 페이지로 리다이렉트
   }
   
   

   @GetMapping("/checkIdDuplicate.do")
   public ResponseEntity<?> checkIdDuplicate(@RequestParam String memberId) {
      boolean available = false;
      try {
         UserDetails memberDetails = memberService.loadUserByUsername(memberId);
      } catch (UsernameNotFoundException e) {
         available = true;
      }

      return ResponseEntity 
            .status(HttpStatus.OK).body(Map.of("available", available, "memberId", memberId));
   }


   @GetMapping("/memberCreateComplete.do")
   public void memberCreateComplete() {
   }

   @GetMapping("/terms.do")
   public void getTerms() {
   }

   @GetMapping("/paymentCompleted.do")
   public void paymentCompleted() {
   }

   @GetMapping("/reviewWrite.do")
   public void reviewWrite() {
   }

   @GetMapping("/myReview.do")
   public void myReview() {
   }

   @GetMapping("/myWishlist.do")
   public void myWishlist() {
   }

   @GetMapping("/petUpdate.do")
   public void petUpdate() {
   }
   
   // 알림 날짜변환메소드 (대원)
   private String formatTimestamp(Timestamp timestamp) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yy/MM/dd HH:mm:ss");
        return dateFormat.format(timestamp);
	}
	// 알림 날짜변환메소드 (대원)
	private String formatTimestampNow() {
	    return formatTimestamp(new Timestamp(System.currentTimeMillis()));
	}
   
   /**
    * 멤버 구독자 업데이트 메소드
    */
   @PostMapping("/subscribe.do")
   public String memberSubscribe(@AuthenticationPrincipal MemberDetails member, RedirectAttributes redirectAttr) {
	   String memberId = member.getMemberId();
	   int result = memberService.memberSubscribe(memberId);
	   if (result > 0)
		   redirectAttr.addFlashAttribute("msg", "🎉멤버쉽 가입이 완료되었습니다. 이제 우동친만의 멤버쉽 혜택을 누려보세요.");
	   return "redirect:/member/myPage.do";
   }
   
}