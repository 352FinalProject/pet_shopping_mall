//package com.shop.app.member.controller;
//
//import java.util.Collection;
//import java.util.Map;
//
//import javax.validation.Valid;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.GrantedAuthority;
//import org.springframework.security.core.annotation.AuthenticationPrincipal;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.stereotype.Controller;
//import org.springframework.validation.BindingResult;
//import org.springframework.validation.ObjectError;
//import org.springframework.validation.annotation.Validated;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import com.shop.app.member.dto.MemberCreateDto;
//import com.shop.app.member.dto.MemberUpdateDto;
//import com.shop.app.member.entity.Member;
//import com.shop.app.member.entity.MemberDetails;
//import com.shop.app.member.service.MemberService;
//
//import lombok.extern.slf4j.Slf4j;
//
//@Controller
//@Slf4j
//@Validated
//@RequestMapping("/member")
//public class MemberSecurityController {
//
//	@Autowired
//	private MemberService memberService;
//	
//	@Autowired
//	private PasswordEncoder passwordEncoder;
//	
//	@GetMapping("/memberCreate.do")
//	public void memberCreate() {}
//	
//	/**
//	 * $2a$10$LDOwiecU8H1aqMb19pEa0.LhJ.VKR5zV/YngckU4cOu0gMPqcbng.
//	 * - 알고리즘 $2a$
//	 * - 옵션 10$ round 숫자 (높으수록 보안성 증가, 속도/메모리 사용량 증가)
//	 * - 랜덤솔트(22자리) LDOwiecU8H1aqMb19pEa0.
//	 * - 해싱값(31자리) LhJ.VKR5zV/YngckU4cOu0gMPqcbng.
//	 * 
//	 * @param member
//	 * @param bindingResult
//	 * @param redirectAttr
//	 * @return
//	 */
//	@PostMapping("/memberCreate.do")
//	public String create(
//			@Valid MemberCreateDto member,
//			BindingResult bindingResult, 
//			RedirectAttributes redirectAttr) {
//		log.debug("member = {}", member);
//		
//		if(bindingResult.hasErrors()) {
//			ObjectError error = bindingResult.getAllErrors().get(0);
//			redirectAttr.addFlashAttribute("msg", error.getDefaultMessage());
//			return "redirect:/member/memberCreate.do";
//		} 
//		
//		
//		
//		
//		String rawPassword = member.getPassword();
//		String encodedPassword = passwordEncoder.encode(rawPassword);
//		log.debug("{} -> {}", rawPassword, encodedPassword);
//		member.setPassword(encodedPassword);
//		
//		int result = memberService.insertMember(member);
//		redirectAttr.addFlashAttribute("msg", "🎉🎉🎉 회원가입을 축하드립니다.🎉🎉🎉");
//		return "redirect:/";
//	}
//	
//	@GetMapping("/memberLogin.do")
//	public void memberLogin() {}
//	
//	// 로그인처리하는 요청 작성 X
//	// 로그아웃처리하는 요청 작성 X
//	
//	
//	@GetMapping("/memberDetail.do")
//	public void memberDetail(
//			Authentication authentication, 
//			@AuthenticationPrincipal MemberDetails member) {
//		log.debug("memberService = {}", memberService);
//		log.debug("authentication = {}", authentication);
//		// UsernamePasswordAuthenticationToken [
//		// 	Principal=MemberDetails(super=Member(memberId=honggd, password=$2a$10$pupH/6vQYLxBdHmRNfJgWe9IvCx8xW3WWEP.I1f8/luO4vJ5ejqBG, name=홍길동, birthday=1999-09-09, email=honggd@naver.com, createdAt=2023-08-02T11:23:48), authorities=[ROLE_USER]), 
//		// 	Credentials=[PROTECTED], 
//		// 	Authenticated=true, 
//		// 	Details=WebAuthenticationDetails [RemoteIpAddress=0:0:0:0:0:0:0:1, SessionId=3D3DBE152CBE700582FDCF31D77692C2], 
//		//  Granted Authorities=[ROLE_USER]]
//		MemberDetails principal = (MemberDetails) authentication.getPrincipal();
//		Object credentials = authentication.getCredentials(); // 열람불가
//		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
//		log.debug("principal = {}", principal);
//		log.debug("credentials = {}", credentials);
//		log.debug("authorities = {}", authorities);
//		
//		log.debug("member = {}", member);
//	}
//	
//	@PostMapping("/memberUpdate.do")
//	public String memberUpdate(
//			@AuthenticationPrincipal MemberDetails principal,
//			@Valid MemberUpdateDto _member, 
//			BindingResult bindingResult, 
//			RedirectAttributes redirectAttr) {
//		log.debug("_member = {}", _member);
//		Member member = _member.toMember();
//		String memberId = principal.getMemberId();
//		member.setMemberId(memberId);
//		// 1. db수정요청
//		int result = memberService.updateMember(member);
//		
//		// 2. security의 authentication 갱신
//		UserDetails memberDetails = memberService.loadUserByUsername(memberId);
//		Authentication newAuthentication = 
//			new UsernamePasswordAuthenticationToken(
//				memberDetails,
//				memberDetails.getPassword(),
//				memberDetails.getAuthorities()
//			);
//		SecurityContextHolder.getContext().setAuthentication(newAuthentication);
//		
//		redirectAttr.addFlashAttribute("msg", "회원정보를 성공적으로 수정했습니다.🎁");
//		return "redirect:/member/memberDetail.do";
//	}
//	
//	/**
//	 * jsckson의존을 통해 json문자열로 자동변환후 응답메세지 출력
//	 * 
//	 * @param memberId
//	 * @return
//	 */
//
//	
//	/**
//	 * ReponseEntity를 반환
//	 * - @ResponseBody 기능 포함. 
//	 * - Generic을 통해 응답객체의 타입제어
//	 * 
//	 * - status code
//	 * - header
//	 * - body
//	 * 
//	 * 
//	 * @param memberId
//	 * @return
//	 */
//	public ResponseEntity<?> checkIdDuplicate(@RequestParam String memberId) {
//		boolean available = false;
//		try {
//			UserDetails memberDetails = memberService.loadUserByUsername(memberId);
//		} catch (UsernameNotFoundException e) {
//			available = true;
//		}
//		
//		return ResponseEntity
//				.status(HttpStatus.OK)
//				.body(Map.of("available", available, "memberId", memberId));
//	}
//	
//	
//	
//}
//
