package com.shop.app.member.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.dto.MemberUpdateDto;
import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.entity.TermsHistory;
import com.shop.app.member.service.MemberService;
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
	private PointService pointService; // 회원가입시 포인트 3000원 적립 
	
	@Autowired
	private TermsService termsService; // 회원가입시 약관동의
	
	@GetMapping("/memberCreate.do") // 회원 생성 페이지로 이동하는 맵핑
	public void memberCreate() {}

	private final Map<String, String> tokenStore = new HashMap<>();
	
	Map<Integer, Accept> userAgreements = new HashMap<>();
	
	@PostMapping("/memberCreate.do") // 회원 생성 처리
	public String memberCreate(
	        @Valid MemberCreateDto member, // 입력된 회원 정보 유효성 검사
	        BindingResult bindingResult, // 유효성 검사 결과
	        RedirectAttributes redirectAttr, HttpSession session) { // 리다이렉트시 전달 할 속성
	    
	    // 이메일 인증 확인 (예라)
	    Boolean isVerified = (Boolean) session.getAttribute("emailVerified");
	    if (isVerified == null || !isVerified) {
	        redirectAttr.addFlashAttribute("msg", "이메일 인증을 해주세요.");
	        return "redirect:/member/memberCreate.do";
	    }
		
		if(bindingResult.hasErrors()) {
		    // bindingResult에 오류가 있을 경우, 즉 유효성 검사에서 문제가 발견된 경우 실행됩니다.
		    ObjectError error = bindingResult.getAllErrors().get(0);
		    // getAllErrors 메서드를 통해 발생한 모든 오류를 가져오고, 첫 번째 오류를 선택.
		    redirectAttr.addFlashAttribute("msg", error.getDefaultMessage());
		    // 오류 메시지를 리다이렉트 애트리뷰트에 "msg"라는 이름으로 추가하여, 리다이렉트 후에도 데이터가 유지.
		    return "redirect:/memberCreate.do";
		    // 유효성 검사 오류 발생 시 사용자를 회원 생성 페이지로 리다이렉트합니다.
		}

		
		// 비밀번호 암호화 처리
		String rawPassword = member.getPassword();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setPassword(encodedPassword);
		
		// 포인트 테이블에 디비 저장 (예라)
		member.setPoint(3000);
		
		// 회원 정보 DB에 저장
		int result = memberService.insertMember(member);
		
		Point point = new Point();
		point.setPointMemberId(member.getMemberId());
		point.setPointCurrent(3000);
		point.setPointType("회원가입");
		point.setPointAmount(3000);
		
	    // 약관 동의 정보 가져오기
	    Object obj = session.getAttribute("userAgreements");
	    log.debug("obj = {}", obj);
	    // Terms 객체 생성
	    Terms terms = new Terms();

	    if (obj instanceof HashMap) {
	        HashMap<Integer, Accept> userAgreements = (HashMap<Integer, Accept>) obj;

	        log.debug("userAgreements = {}", userAgreements);
	        // 회원 id 설정 (회원가입이 완료된 후에 설정)
	        terms.setMemberId(member.getMemberId());

	        List<TermsHistory> findTermsHistory = termsService.fineTermsHistory();
	        
	        log.debug("findTermsHistory = {}", findTermsHistory);
	        
	        for (TermsHistory th : findTermsHistory) {
	            terms.setHistoryId(th.getTermsId());
	            terms.setTermsId(th.getTermsId());
	            terms.setAccept(userAgreements.getOrDefault(th.getTermsId(), Accept.N));
	            
	            int result2 = termsService.insertTerms(terms);
	            log.debug("result2 = {}", result2);
	        }

	        // 약관 동의 세션 제거
	        session.removeAttribute("terms");

	    } else {
	        redirectAttr.addFlashAttribute("msg", "약관에 동의해주세요.");
	        return "redirect:/member/terms.do";
	    }
	
		// 회원 정보 세션 제거 (예라)
		session.removeAttribute("emailVerified");
		
		return "redirect:/memberCreateComplete.do";
	}
	
	// 약관 동의 정보를 세션에 임시 저장 (예라)
	@PostMapping("/updateTerms.do") 
	public ResponseEntity<?> updateTerms(
	        @RequestParam Map<String, String> data, 
	        HttpSession session) {

	    String term = data.get("termsAccept");
	    String privacy = data.get("privacyAccept");
	    String promotion = data.get("emailAccept");

	    // 사용자가 동의한 항목에 대해 Map에 저장
	    userAgreements.put(1, "Y".equals(term) ? Accept.Y : Accept.N);
	    userAgreements.put(2, "Y".equals(privacy) ? Accept.Y : Accept.N); 
	    userAgreements.put(3, "Y".equals(promotion) ? Accept.Y : Accept.N);

	    session.setAttribute("userAgreements", userAgreements);

	    return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping("/memberLogin.do") // 로그인 페이지로 이동하는 맵핑
	public void memberLogin(){}
	
	
	// 로그인처리하는 요청 작성 X
	// 로그아웃처리하는 요청 작성 X
	
	// 멤버 상세 조회
	@GetMapping("/myPage.do")
	public void memberDetail(
			Authentication authentication, // 현재 사용자 인증 정보와 멤버 정보를 가져와서 상세 정보 페이지에 표시. 
			@AuthenticationPrincipal MemberDetails _member, // member: 현재 사용자 멤버 정보
			Model model
			) { // model: 뷰와 컨트롤러 사이에서 데이터를 전달하는 객체 
		
		// 현재 인증된 사용자가 가진 권한(롤) 목록을 가져옴.
		// 예를 들어, 사용자가 'ROLE_USER', 'ROLE_ADMIN' 등의 권한을 가지고 있다면, 이를 가져올 수 있음.
		MemberDetails principal = (MemberDetails) authentication.getPrincipal();
		Object credentials = authentication.getCredentials(); // 열람불가
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		
		Member member = memberService.findMemberById(_member.getMemberId());
		
		log.debug("member = {}", member);
		
	    model.addAttribute("member", member);
	    
	}
	
	// 멤버 정보 업데이트
	@PostMapping("/memberUdapte.do")
	public String memberUpdate(
			@AuthenticationPrincipal MemberDetails principal, // 현재 인증된 멤버 정보
			@Valid MemberUpdateDto _member,
			HttpSession session,
			BindingResult bindingResult, 
			RedirectAttributes redirectAttr) {
		Member member = _member.toMember();
		String memberId = principal.getMemberId();
		member.setMemberId(memberId);
		
		 // 새로운 비밀번호가 입력되었을 경우 암호화 처리
	    if (_member.getPassword() != null && !_member.getPassword().isEmpty()) {
	        String rawPassword = _member.getPassword();
	        String encodedPassword = passwordEncoder.encode(rawPassword);
	        member.setPassword(encodedPassword);
	    }
		// 1. db수정요청
		int result = memberService.updateMember(member);
		
		// 2. security의 authentication 갱신
		UserDetails memberDetails = memberService.loadUserByUsername(memberId);
		Authentication newAuthentication = 
			new UsernamePasswordAuthenticationToken(
				memberDetails,
				memberDetails.getPassword(),
				memberDetails.getAuthorities()
			);
		SecurityContextHolder.getContext().setAuthentication(newAuthentication);
		
	    session.invalidate(); // 세션 종료
		redirectAttr.addFlashAttribute("msg", "회원정보를 성공적으로 수정했습니다.🎁");
		return "redirect:/member/myPage.do";
	}
	
	@PostMapping("/deleteMember.do")
	public String deleteMember(@AuthenticationPrincipal MemberDetails principal, RedirectAttributes redirectAttr, HttpSession session) {
	    String memberId = principal.getMemberId(); // 현재 로그인한 회원의 ID를 가져옵니다.
	    memberService.deleteMember(memberId);  // 회원 삭제 서비스 호출
	    session.invalidate(); // 세션 종료
	    
	    return "redirect:/"; // 로그아웃 후 메인 페이지로 리다이렉트
	}

	@GetMapping("/checkIdDuplicate.do")
	
	// 중복 ID 검사
	public ResponseEntity<?> checkIdDuplicate(@RequestParam String memberId) {
		boolean available = false;
		try {
			UserDetails memberDetails = memberService.loadUserByUsername(memberId);
		} catch (UsernameNotFoundException e) {
			available = true; // 사용가능한 ID일 경우 true
		}
		
		return ResponseEntity // 응답 상태와 정보 반환
				.status(HttpStatus.OK)
				.body(Map.of("available", available, "memberId", memberId));
	}

	//아이디 찾기 
	@GetMapping("/memberSearchId.do")
	public void memberSearchId(){}
	
	
	@GetMapping("/memberCreateComplete.do")
	public void memberCreateComplete() {}
	
	
	@GetMapping("/terms.do")
	public void getTerms() {}
	
	@GetMapping("/paymentCompleted.do")
	public void paymentCompleted(){}
	
	@GetMapping("/reviewWrite.do")
	public void reviewWrite() {}
	
	@GetMapping("/myReview.do")
	public void myReview() {}
	
	@GetMapping("/myWishlist.do")
	public void myWishlist() {}

	@GetMapping("/petUpdate.do")
	public void petUpdate() {}
}

