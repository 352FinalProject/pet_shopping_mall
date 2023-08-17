//package com.shop.app.oauth.controller;
//
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.SessionAttributes;
//import org.springframework.web.servlet.view.RedirectView;
//
//import com.shop.app.member.dto.MemberCreateDto;
//import com.shop.app.member.entity.MemberDetails;
//import com.shop.app.member.service.MemberService;
//import com.shop.app.oauth.service.NaverService;  
//
//import lombok.extern.slf4j.Slf4j;
//
//@Controller
//@Slf4j
//@RequestMapping("/oauth/naver")  // 수정된 부분
//@SessionAttributes({"access_token", "refresh_token"})
//public class NaverController {
//	
//	@Autowired
//	private NaverService naverService;  // 수정된 부분
//
//	@Autowired
//	private MemberService memberService;
//	
//	@GetMapping("/login.do")
//	public RedirectView login() {
//		return new RedirectView(naverService.getAuthorizeUri());  // 수정된 부분
//	}
//
//	@GetMapping("/callback.do")
//	public RedirectView callback(@RequestParam String code, Model model, HttpServletRequest request) {
//		Map<String, Object> tokens = naverService.getTokens(code);  // 수정된 부분
//		
//		model.addAttribute("access_token", tokens.get("access_token"));
//		model.addAttribute("refresh_token", tokens.get("refresh_token"));
//
//		Map<String, Object> attributes = naverService.getProfile((String) tokens.get("access_token"));  // 수정된 부분
//		
//		String memberId = attributes.get("id") + "@naver";  // 수정된 부분
//		MemberDetails member = null;
//		try {
//			member = (MemberDetails) memberService.loadUserByUsername(memberId);
//		} catch(UsernameNotFoundException ignore) {
//			Map<String, Object> naverAccount = (Map<String, Object>) attributes.get("response");  // 네이버에서는 'response' 키에 사용자 정보가 포함됩니다.
//			
//			String name = (String) naverAccount.get("name");
//			String email = (String) naverAccount.get("email");
//			MemberCreateDto memberCreateDto = 
//					MemberCreateDto.builder()
//						.memberId(memberId)
//						.password("1234")
//						.name(name)
//						.email(email)
//						.build();
//			
//			int result = memberService.insertMember(memberCreateDto);
//			member = (MemberDetails) memberService.loadUserByUsername(memberId);
//		}
//		
//		Authentication authentication = new UsernamePasswordAuthenticationToken(
//				member, 
//				member.getPassword(),
//				member.getAuthorities()
//			);
//		SecurityContextHolder.getContext().setAuthentication(authentication);
//		
//		return new RedirectView(request.getContextPath() + "/");
//	}
//}
