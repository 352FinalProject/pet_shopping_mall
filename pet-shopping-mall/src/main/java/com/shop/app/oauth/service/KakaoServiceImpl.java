package com.shop.app.oauth.service;

import java.net.URI;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class KakaoServiceImpl implements KakaoService {

	// 카카오 인증 관련 설정값들
	@Value("${oauth.kakao.authorize-uri}")
	private String AUTHORIZE_URI;
	@Value("${oauth.kakao.redirect-uri}")
	private String REDIRECT_URI;
	@Value("${oauth.kakao.rest-api-key}")
	private String REST_API_KEY;
	@Value("${oauth.kakao.token-uri}")
	private String TOKEN_URI;
	@Value("${oauth.kakao.scope}")
	private String SCOPE;
	@Value("${oauth.kakao.resource-uri-host}")
	private String RESOURCE_URI_HOST;

	/**
	 * 카카오 인증 요청을 위한 URI 생성
	 * @return 카카오 인증 요청 URI
	 */
	@Override
	public String getAuthorizeUri() {
		return AUTHORIZE_URI
			+ "?redirect_uri=" + REDIRECT_URI
			+ "&response_type=code"
			+ "&client_id=" + REST_API_KEY
			+ "&scope=" + SCOPE;
	}

	/**
	 * 코드를 이용해 액세스 토큰과 리프레시 토큰을 발급 받는 메서드.
	 * - 액세스 토큰: 사용자 정보나 특정 권한을 얻기 위한 키, 일반적으로 만료시간이 짧음.
	 * - 리프레시 토큰: 액세스 토큰을 재발급 받기 위한 키, 만료시간이 길게 설정됨.
	 *
	 * @param code 카카오로부터 받은 인증 코드
	 * @return 토큰 정보를 담은 Map
	 */
	@Override
	public Map<String, Object> getTokens(String code) {
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders httpHeaders = new HttpHeaders();
		HttpEntity<HttpHeaders> httpEntity = new HttpEntity<>(httpHeaders);

		String uri = TOKEN_URI
				   + "?grant_type=authorization_code"
				   + "&client_id=" + REST_API_KEY
				   + "&redirect_uri=" + REDIRECT_URI
				   + "&code=" + code;
		ResponseEntity<?> responseEntity = 
				 restTemplate.exchange(URI.create(uri), HttpMethod.GET, httpEntity, Map.class);
		return (Map<String, Object>) responseEntity.getBody();
	}

	/**
	 * 액세스 토큰을 이용해 카카오 사용자 정보를 가져옴.
	 *
	 * @param accessToken 사용자의 액세스 토큰
	 * @return 사용자 정보를 담은 Map
	 */
	@Override
	public Map<String, Object> getProfile(String accessToken) {
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setBearerAuth(accessToken);
		HttpEntity<HttpHeaders> httpEntity = new HttpEntity<>(httpHeaders);
		String uri = RESOURCE_URI_HOST + "/v2/user/me";

		ResponseEntity<Map<String, Object>> responseEntity = 
				restTemplate.exchange(
						URI.create(uri), 
						HttpMethod.GET, 
						httpEntity, 
						new ParameterizedTypeReference<Map<String, Object>>(){});

		return responseEntity.getBody();
	}
}
