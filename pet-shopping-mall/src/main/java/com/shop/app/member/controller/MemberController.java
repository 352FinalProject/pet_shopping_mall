package com.shop.app.member.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.dto.MemberLoginDto;
import com.shop.app.member.entity.Member;
import com.shop.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Validated
@RequestMapping("/member")
//@SessionAttributes({ "loginMember" })
@Slf4j
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@GetMapping("/memberCreate.do")
	public void memberCreate() {}
	
	@PostMapping("/memberCreate.do")
	
	public String memberCreate(
			@Valid MemberCreateDto member,
			BindingResult bindingResult, 
			RedirectAttributes redirectAttr) {
		log.debug("member = {}", member);
		
		if(bindingResult.hasErrors()) {
			ObjectError error = bindingResult.getAllErrors().get(0);
			redirectAttr.addFlashAttribute("msg", error.getDefaultMessage());
			return "redirect:/member/memberCreate.do";
		} 
		
		String rawPassword = member.getPassword();
//		String encodedPassword = passwordEncoder.encode(rawPassword);
//		log.debug("{} -> {}", rawPassword, encodedPassword);
//		member.setPassword(encodedPassword);
		
		int result = memberService.insertMember(member);
		redirectAttr.addFlashAttribute("msg", "🎉🎉🎉 회원가입을 축하드립니다.🎉🎉🎉");
		return "redirect:/";
	}

	@GetMapping("/memberLogin.do")
	public void memberLogin(){}
	
	@PostMapping("/memberLogin.do")
	public String memberLogin(
			@Valid MemberLoginDto _member, 
			BindingResult bindingResult, 
			Model model) {
		log.debug("_member = {}", _member);
		
		// 1. 아이디로 Member 조회
		Member member = memberService.findMemberById(_member.getMemberId());
		log.debug("member = {}", member);
		log.debug("temp = {}", passwordEncoder.encode("1234"));
		
		// 2. 로그인 성공(세션에 로그인객체 저장)/실패(에러메세지 전달)
		if(member != null && passwordEncoder.matches(_member.getPassword(), member.getPassword())) {
			// 로그인 성공
			// 클래스레벨 @SessionAttributes({"loginMember"}) 작성후 session scope 저장
			model.addAttribute("loginMember", member);
		}
		else {
			// 로그인 실패
			return "redirect:/member/memberLogin.do?error";
		}
		
		
		return "redirect:/";
	}
	
	@GetMapping("/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus) {
		if(!sessionStatus.isComplete())
			sessionStatus.setComplete();
		return "redirect:/";
	}
	
	@GetMapping("/paymentCompleted.do")
	public void paymentCompleted(){}
	
	

	@GetMapping("/petProfile.do")
	public void petProfile() {}
	
	@GetMapping("/reviewWrite.do")
	public void reviewWrite() {}
	
	@GetMapping("/myReview.do")
	public void myReview() {}
	

}
