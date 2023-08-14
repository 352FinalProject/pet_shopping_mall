package com.shop.app.member.controller;

import java.util.Collection;
import java.util.Map;

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
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.dto.MemberUpdateDto;
import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.service.MemberService;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;

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
	
	@GetMapping("/memberCreate.do") // 회원 생성 페이지로 이동하는 맵핑
	public void memberCreate() {}
	

	@PostMapping("/memberCreate.do") // 회원 생성 처리
	public String create(
			@Valid MemberCreateDto member, // 입력된 회원 정보 유효성 검사
			BindingResult bindingResult, // 유효성 검사 결과
			RedirectAttributes redirectAttr) { // 리다이렉트시 전달 할 속성
		log.debug("member = {}", member);
		
		if(bindingResult.hasErrors()) {
		    // bindingResult에 오류가 있을 경우, 즉 유효성 검사에서 문제가 발견된 경우 실행됩니다.
		    ObjectError error = bindingResult.getAllErrors().get(0);
		    // getAllErrors 메서드를 통해 발생한 모든 오류를 가져오고, 첫 번째 오류를 선택.
		    redirectAttr.addFlashAttribute("msg", error.getDefaultMessage());
		    // 오류 메시지를 리다이렉트 애트리뷰트에 "msg"라는 이름으로 추가하여, 리다이렉트 후에도 데이터가 유지.
		    return "redirect:/member/memberCreate.do";
		    // 유효성 검사 오류 발생 시 사용자를 회원 생성 페이지로 리다이렉트합니다.
		}

		
		// 비밀번호 암호화 처리
		String rawPassword = member.getPassword();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		log.debug("{} -> {}", rawPassword, encodedPassword);
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
		
		int resultPoint = pointService.givePointsForSignUp(point);
		
		redirectAttr.addFlashAttribute("msg", "🎉🎉🎉 회원가입을 축하드립니다.🎉🎉🎉");
		return "redirect:/";
	}
	
	@GetMapping("/memberLogin.do") // 로그인 페이지로 이동하는 맵핑
	public void memberLogin() {}
	
	// 로그인처리하는 요청 작성 X
	// 로그아웃처리하는 요청 작성 X
	
	// 멤버 상세 조회
	@GetMapping("/memberDetail.do")
	public void memberDetail(
			Authentication authentication, 
			@AuthenticationPrincipal MemberDetails member) { // 현재 인증 객체
		log.debug("memberService = {}", memberService);
		log.debug("authentication = {}", authentication);
		// UsernamePasswordAuthenticationToken [
		// 	Principal=MemberDetails(super=Member(memberId=honggd, password=$2a$10$pupH/6vQYLxBdHmRNfJgWe9IvCx8xW3WWEP.I1f8/luO4vJ5ejqBG, name=홍길동, birthday=1999-09-09, email=honggd@naver.com, createdAt=2023-08-02T11:23:48), authorities=[ROLE_USER]), 
		// 	Credentials=[PROTECTED], 
		// 	Authenticated=true, 
		// 	Details=WebAuthenticationDetails [RemoteIpAddress=0:0:0:0:0:0:0:1, SessionId=3D3DBE152CBE700582FDCF31D77692C2], 
		//  Granted Authorities=[ROLE_USER]]
		
		// 현재 인증된 사용자가 가진 권한(롤) 목록을 가져옴.
		// 예를 들어, 사용자가 'ROLE_USER', 'ROLE_ADMIN' 등의 권한을 가지고 있다면, 이를 가져올 수 있음.
		MemberDetails principal = (MemberDetails) authentication.getPrincipal();
		Object credentials = authentication.getCredentials(); // 열람불가
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		log.debug("principal = {}", principal);
		log.debug("credentials = {}", credentials);
		log.debug("authorities = {}", authorities);
		
		log.debug("member = {}", member);
	}
	
	// 멤버 정보 업데이트
	@PostMapping("/memberUpdate.do")
	public String memberUpdate(
			@AuthenticationPrincipal MemberDetails principal, // 현재 인증된 멤버 정보
			@Valid MemberUpdateDto _member, 
			BindingResult bindingResult, 
			RedirectAttributes redirectAttr) {
		log.debug("_member = {}", _member);
		Member member = _member.toMember();
		String memberId = principal.getMemberId();
		member.setMemberId(memberId);
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
		
		redirectAttr.addFlashAttribute("msg", "회원정보를 성공적으로 수정했습니다.🎁");
		return "redirect:/member/memberDetail.do";
	}
	
	/**
	 * jsckson의존을 통해 json문자열로 자동변환후 응답메세지 출력
	 * 
	 * @param memberId
	 * @return
	 */

	
	/**
	 * ReponseEntity를 반환
	 * - @ResponseBody 기능 포함. 
	 * - Generic을 통해 응답객체의 타입제어
	 * 
	 * - status code
	 * - header
	 * - body
	 * 
	 * 
	 * @param memberId
	 * @return
	 */
	
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
	
	
	@GetMapping("/paymentCompleted.do")
	public void paymentCompleted(){}
	
	@GetMapping("/petProfile.do")
	public void petProfile() {}
	
	@GetMapping("/reviewWrite.do")
	public void reviewWrite() {}
	
	@GetMapping("/myReview.do")
	public void myReview() {}
	
	@GetMapping("/myPage.do")
	public void myPage() {}
	
	@GetMapping("/terms.do")
	public void terms() {}
	
}

