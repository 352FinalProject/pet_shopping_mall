package com.shop.app.payment.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import lombok.Getter;

@Getter
@Component
public class IamportApi {
	@Value("${external.api.key}")
	private String apiKey;
	
	@Value("${external.api.secret}")
	private String apiSecret;
	
}
