package com.shop.app.oauth.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AccessToken;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class OAuth2UserServiceImpl extends DefaultOAuth2UserService{

	@Autowired
	private MemberService memberService;
	
	/**
	 * code/token 교환후 가져온 사용자정보를 인자로 전달
	 * MemberDetails를 OAuth2User 구현클래스로 사용
	 */
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		
		ClientRegistration clientRegistration = userRequest.getClientRegistration(); // IDP
		OAuth2AccessToken accessToken = userRequest.getAccessToken();
		OAuth2User oauth2User = super.loadUser(userRequest);
		log.debug("clientRegistration = {}", clientRegistration);
		log.debug("accessToken = {}", accessToken.getTokenValue());
		log.debug("oauth2User = {}", oauth2User);
		
		Map<String, Object> attributes = oauth2User.getAttributes();
		String memberId = attributes.get("id") + "@kakao";
		MemberDetails member = null;
	
		// 기존회원 가입여부 조회 (회원가입처리)
		try {
			member = (MemberDetails) memberService.loadUserByUsername(memberId);
		} catch (UsernameNotFoundException ignore) {
			Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
			Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");
			
			String name = (String) profile.get("nickname");
			String email = (String) kakaoAccount.get("email");
			MemberCreateDto memberCreateDto = 
					MemberCreateDto.builder()
						.memberId(memberId)
						.password("1234")
						.name(name)
						.email(email)
						.build();
			
			int result = memberService.insertMember(memberCreateDto);
			member = (MemberDetails) memberService.loadUserByUsername(memberId);
		}
		
		return member;
	}
	
}
