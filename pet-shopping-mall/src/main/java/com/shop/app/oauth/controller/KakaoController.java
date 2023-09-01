package com.shop.app.oauth.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.service.MemberService;
import com.shop.app.oauth.service.KakaoService;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;

import lombok.extern.slf4j.Slf4j;


@Controller  // 이 클래스가 MVC 패턴의 컨트롤러 역할을 한다는 것을 나타내는 어노테이션
@Slf4j  // Lombok을 통해 로깅을 위한 log 객체를 자동 생성
@RequestMapping("/oauth/kakao")  // 해당 컨트롤러의 기본 URL 경로를 설정
@SessionAttributes({"access_token", "refresh_token"})  // 세션에 "access_token"과 "refresh_token" 속성을 저장
public class KakaoController {
	
	@Autowired  // 자동으로 해당 타입의 빈을 주입
	private KakaoService kakaoService;

	@Autowired
	private MemberService memberService;

	
	@GetMapping("/login.do")
	public RedirectView login() {
		// 카카오 로그인 페이지로 리다이렉트하는 URL을 반환
		return new RedirectView(kakaoService.getAuthorizeUri());
	}

	@GetMapping("/callback.do")
	public RedirectView callback(@RequestParam String code, Model model, HttpServletRequest request) {
		// 1. 사용자가 카카오 로그인 후, 리다이렉트될 때 코드를 포함하여 호출됨
		Map<String, Object> tokens = kakaoService.getTokens(code);
		// 사용자 세션에 액세스 토큰과 리프레시 토큰을 저장
		model.addAttribute("access_token", tokens.get("access_token"));
		model.addAttribute("refresh_token", tokens.get("refresh_token"));
		
		// 2. 액세스 토큰을 사용하여 카카오에 사용자 정보를 요청
		Map<String, Object> attributes = kakaoService.getProfile((String) tokens.get("access_token"));
		
		// 3. 얻어온 사용자 정보를 기반으로 회원가입 및 로그인 처리
		String memberId = attributes.get("id") + "@kakao";
		MemberDetails member = null;
		try {
			// 이미 가입된 회원인지 조회
			member = (MemberDetails) memberService.loadUserByUsername(memberId);
		} catch(UsernameNotFoundException ignore) {
			// 회원이 아닌 경우 회원가입 처리
			Map<String, Object> oauth2Account = (Map<String, Object>) attributes.get("kakao_account");
			Map<String, Object> profile = (Map<String, Object>) oauth2Account.get("profile");
			
			String name = (String) profile.get("nickname");
			String email = (String) oauth2Account.get("email");
			MemberCreateDto memberCreateDto = 
					MemberCreateDto.builder()
						.memberId(memberId)
						.password("1234")
						.name(name)
						.email(email)
						.build();
			
			  int result = memberService.insertMember(memberCreateDto);

			// 회원가입 후, 다시 회원 정보를 조회
			member = (MemberDetails) memberService.loadUserByUsername(memberId);
			
		}
		
		// 회원 정보를 기반으로 시큐리티 인증 처리
		Authentication authentication = new UsernamePasswordAuthenticationToken(
				member, 
				member.getPassword(),
				member.getAuthorities()
			);
		SecurityContextHolder.getContext().setAuthentication(authentication);
		// 인증 처리 후 메인 페이지로 리다이렉트
		return new RedirectView(request.getContextPath() + "/");
	}
}

