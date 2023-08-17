package com.shop.app.oauth.service;

import java.util.Map;

public interface NaverService {

	/**
	 * 카카오 인증 URL을 가져오는 메서드.
	 * @return 카카오 인증 URL
	 */
	String getAuthorizeUri();

	/**
	 * 인증 코드를 통해 액세스 토큰과 리프레시 토큰을 가져오는 메서드.
	 * @param code 카카오에서 제공받은 인증 코드
	 * @return 토큰 정보를 담은 Map (일반적으로 "access_token"과 "refresh_token" 키를 포함)
	 */
	Map<String, Object> getTokens(String code);

	/**
	 * 액세스 토큰을 사용하여 카카오에서 사용자 프로필 정보를 가져오는 메서드.
	 * @param accessToken 사용자의 액세스 토큰
	 * @return 사용자 프로필 정보를 담은 Map
	 */
	Map<String, Object> getProfile(String accessToken);
}
