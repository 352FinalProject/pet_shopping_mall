package com.shop.app.payment.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shop.app.payment.controller.IamportApi;

import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;

@Slf4j
@Service
public class SchedulePay {
	
	@Autowired
	private IamportApi iamportApi;
	public static final String IMPORT_SCHEDULE_URL = "https://api.iamport.kr/subscribe/payments/schedule";

    // ObjectMapper를 주입
    @Autowired
    private ObjectMapper objectMapper;

    public String schedulePay(String merchantUid, String customerUid, int amount) {
    	
    	String token = iamportApi.getImportToken();

    	HttpHeaders headers = new HttpHeaders();
    	headers.setContentType(MediaType.APPLICATION_JSON);
    	headers.setBearerAuth(token);
    	

        LocalDateTime currentDateTime = LocalDateTime.now();
        LocalDateTime oneMonthLater = currentDateTime.plusMonths(1);

        long scheduleAtTimestampSeconds = oneMonthLater.toEpochSecond(ZoneOffset.UTC);

    	Map<String, Object> scheduleMap = new HashMap<>();
    	scheduleMap.put("amount", 1000);
    	scheduleMap.put("currency", "KRW");
    	scheduleMap.put("schedule_at", scheduleAtTimestampSeconds);
    	scheduleMap.put("merchant_uid", "bill" + scheduleAtTimestampSeconds);

    	List<Map<String, Object>> schedulesList = new ArrayList<>();
    	schedulesList.add(scheduleMap);

    	Map<String, Object> requestMap = new HashMap<>();
    	requestMap.put("customer_uid", "honggd");
    	requestMap.put("schedules", schedulesList);

    	String requestBody;
    	try {
    	    requestBody = objectMapper.writeValueAsString(requestMap);
    	} catch (Exception e) {
    	    return "JSON 변환 에러 error";
    	}

    	RestTemplate restTemplate = new RestTemplate();

    	HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

    	String result = restTemplate.postForObject(IMPORT_SCHEDULE_URL, entity, String.class);

    	return result;
    }
}
