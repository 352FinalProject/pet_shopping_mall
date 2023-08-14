package com.shop.app.oauth.service;

import java.util.Map;

public interface KakaoService {

	String getAuthorizeUri();

	Map<String, Object> getTokens(String code);

	Map<String, Object> getProfile(String accessToken);

}
