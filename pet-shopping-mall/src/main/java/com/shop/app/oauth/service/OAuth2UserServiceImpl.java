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
import com.shop.app.oauth.entity.LoginProvider;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class OAuth2UserServiceImpl extends DefaultOAuth2UserService{

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PointService pointService;

	/**
	 * 카카오 인증 후 반환된 code 또는 토큰을 이용하여 사용자 정보를 가져옴.
	 * 만약 해당 사용자가 이미 회원가입된 경우, 해당 회원 정보를 반환.
	 * 아직 회원가입되지 않은 경우, 카카오에서 제공된 정보로 회원가입 처리 후, 회원 정보를 반환.
	 *
	 * @param userRequest OAuth2User의 요청 정보, IDP 정보, 액세스 토큰 등을 포함.
	 * @return OAuth2User 정보. 여기서는 MemberDetails 객체를 반환.
	 * @throws OAuth2AuthenticationException 인증 오류 시 발생
	 * 
	 * @author 전예라
	 * 소셜로그인 회원가입 시 포인트 적립
	 */
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

		ClientRegistration clientRegistration = userRequest.getClientRegistration(); // IDP 정보 가져오기
	    String provider = clientRegistration.getRegistrationId().toUpperCase(); // 이를 통해 'KAKAO' 또는 'NAVER'를 가져올 수 있습니다.

		
		OAuth2AccessToken accessToken = userRequest.getAccessToken(); // 액세스 토큰 가져오기
		OAuth2User oauth2User = super.loadUser(userRequest); // 상위 클래스의 사용자 정보 로드 메서드 호출
		
		Map<String, Object> attributes = oauth2User.getAttributes();
		String memberId = null;
		
//		String memberId = attributes.get("id") + "@kakao"; //kakao
//		MemberDetails member = null;
	    if (LoginProvider.valueOf(provider) == LoginProvider.KAKAO) {
	        memberId = attributes.get("id") + "@kakao";
	    } else if (LoginProvider.valueOf(provider) == LoginProvider.NAVER) {
	        memberId = attributes.get("id") + "@naver";
	        // 주의: NAVER의 'id'가 다른 경우 속성 추출 로직을 조정해야 합니다.
	    }

		MemberDetails member = null;
	    
		  try {
		        member = (MemberDetails) memberService.loadUserByUsername(memberId);
		    } catch (UsernameNotFoundException ignore ) {
		        if (LoginProvider.valueOf(provider) == LoginProvider.KAKAO) {
		            Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
		            Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");

		            String name = (String) profile.get("nickname");
		            String email = (String) kakaoAccount.get("email");
		            
		            MemberCreateDto memberCreateDto = MemberCreateDto.builder()
		                .memberId(memberId)
		                .password("1234") 
		                .name(name)
		                .email(email)
		                .build();

		            int result = memberService.insertMember(memberCreateDto);
		            member = (MemberDetails) memberService.loadUserByUsername(memberId);
					
					Point point = new Point();
					point.setPointMemberId(member.getMemberId());
					point.setPointCurrent(3000);
					point.setPointType("회원가입");
					point.setPointAmount(3000);
					
					int resultPoint = pointService.insertPoint(point);

		        } else if (LoginProvider.valueOf(provider) == LoginProvider.NAVER) {
		            // NAVER 특정 속성을 사용하여 회원을 생성하는 방법을 처리합니다.
		            // 올바른 속성을 추출하기 위해 로직을 조정해야 합니다.
		        	
		        	   Map<String, Object> naverAccount = (Map<String, Object>) attributes.get("response");
		        	   String name = (String) naverAccount.get("name");
			           String email = (String) naverAccount.get("email");
			            
			            MemberCreateDto memberCreateDto = MemberCreateDto.builder()
			                .memberId(memberId)
			                .password("1234") 
			                .name(name)
			                .email(email)
			                .build();

			            int result = memberService.insertMember(memberCreateDto);
			            member = (MemberDetails) memberService.loadUserByUsername(memberId);
						
						Point point = new Point();
						point.setPointMemberId(member.getMemberId());
						point.setPointCurrent(3000);
						point.setPointType("회원가입");
						point.setPointAmount(3000);
						
						int resultPoint = pointService.insertPoint(point);
		        }
		    }

		    return member;
		}
		// 이미 등록된 회원인지 확인
//		try {
//			member = (MemberDetails) memberService.loadUserByUsername(memberId);
//		} catch (UsernameNotFoundException ignore) {
//			// 회원이 아니라면 카카오 정보로 회원가입
//			Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
//			Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");
//			
//			String name = (String) profile.get("nickname");
//			String email = (String) kakaoAccount.get("email");
//			MemberCreateDto memberCreateDto = 
//					MemberCreateDto.builder()
//						.memberId(memberId)
//						.password("1234")  // 기본 패스워드 설정
//						.name(name)
//						.email(email)
//						.build();
//			
//			// DB에 회원 정보 저장
//			int result = memberService.insertMember(memberCreateDto);
//			member = (MemberDetails) memberService.loadUserByUsername(memberId);
//		}
//		
//		return member;
//	}
}