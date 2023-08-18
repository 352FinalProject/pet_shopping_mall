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
public class NaverServiceImpl implements NaverService { 

	// 네이버 인증 관련 설정값들
	@Value("${oauth.naver.authorize-uri}")
	private String AUTHORIZE_URI;
	@Value("${oauth.naver.redirect-uri}")
	private String REDIRECT_URI;
	@Value("${oauth.naver.client-id}")
	private String CLIENT_ID;
	@Value("${oauth.naver.client-secret}")
	private String CLIENT_SECRET;
	@Value("${oauth.naver.token-uri}")
	private String TOKEN_URI;
	@Value("${oauth.naver.resource-uri-host}")
	private String RESOURCE_URI_HOST;

	@Override
	public String getAuthorizeUri() {
		return AUTHORIZE_URI
			+ "?response_type=code"
			+ "&client_id=" + CLIENT_ID
			+ "&redirect_uri=" + REDIRECT_URI
			+ "&state=state_string"; // 'state' 파라미터는 CSRF 방어를 위한 임의의 문자열로 설정됩니다.
	}

	@Override
	public Map<String, Object> getTokens(String code) {
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Authorization", "Basic " + CLIENT_SECRET);
		HttpEntity<HttpHeaders> httpEntity = new HttpEntity<>(httpHeaders);

		String uri = TOKEN_URI
				   + "?grant_type=authorization_code"
				   + "&client_id=" + CLIENT_ID
				   + "&client_secret=" + CLIENT_SECRET
				   + "&redirect_uri=" + REDIRECT_URI
				   + "&code=" + code;
		ResponseEntity<?> responseEntity = 
				 restTemplate.exchange(URI.create(uri), HttpMethod.GET, httpEntity, Map.class);
		return (Map<String, Object>) responseEntity.getBody();
	}

	@Override
	public Map<String, Object> getProfile(String accessToken) {
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setBearerAuth(accessToken);
		HttpEntity<HttpHeaders> httpEntity = new HttpEntity<>(httpHeaders);
		String uri = RESOURCE_URI_HOST + "/v1/nid/me";

		ResponseEntity<Map<String, Object>> responseEntity = 
				restTemplate.exchange(
						URI.create(uri), 
						HttpMethod.GET, 
						httpEntity, 
						new ParameterizedTypeReference<Map<String, Object>>(){});

		return responseEntity.getBody();
	}
}
