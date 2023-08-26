package com.shop.app.payment.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
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

    	long currentTimestampMillis = System.currentTimeMillis();

    	// Construct the schedules array
    	Map<String, Object> scheduleMap = new HashMap<>();
    	scheduleMap.put("amount", 1000);
    	scheduleMap.put("currency", "KRW");
    	scheduleMap.put("schedule_at", currentTimestampMillis);
    	scheduleMap.put("merchant_uid", "bill" + currentTimestampMillis);

    	List<Map<String, Object>> schedulesList = new ArrayList<>();
    	schedulesList.add(scheduleMap);

    	// Construct the request object
    	Map<String, Object> requestMap = new HashMap<>();
    	requestMap.put("customer_uid", "honggd");
    	requestMap.put("schedules", schedulesList);

    	// Convert the request object to JSON string
    	String requestBody;
    	try {
    	    requestBody = objectMapper.writeValueAsString(requestMap);
    	} catch (Exception e) {
    	    return "JSON 변환 에러 error";
    	}

    	RestTemplate restTemplate = new RestTemplate();

    	HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

    	String result = restTemplate.postForObject(IMPORT_SCHEDULE_URL, entity, String.class);

    	log.debug("result = {}", result);

    	return result;
    	
    	
//        String token = iamportApi.getImportToken();
//
//        HttpHeaders headers = new HttpHeaders();
//        headers.setContentType(MediaType.APPLICATION_JSON);
//        headers.setBearerAuth(token);
//
//        long currentTimestampMillis = System.currentTimeMillis();
//
//        // Map을 사용하여 JSON 객체 생성
//        Map<String, Object> requestMap = new HashMap<>();
//        requestMap.put("merchant_uid", merchantUid);
//        requestMap.put("schedule_at", currentTimestampMillis);
//        requestMap.put("amount", amount);
//        requestMap.put("currency", "KRW");
//        
//        JSONArray jsonArr = new JSONArray();
//        jsonArr.put(new JSONObject(requestMap));
//        
//        JSONObject infos = new JSONObject();
//        infos.append("customer_uid", customerUid);
//        infos.append("schedules", jsonArr);
//        
//        log.debug("infos = {}",infos);
//        
//        
//        String requestBody;
//        try {
//            requestBody = objectMapper.writeValueAsString(infos);
//        } catch (Exception e) {
//            return "JSON 변환 에러 error";
//        }
//
//        RestTemplate restTemplate = new RestTemplate();
//
//        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);
//        
//        
//        String result = restTemplate.postForObject(IMPORT_SCHEDULE_URL, entity, String.class);
//        
//        log.debug("result = {}", result);
//        
//        return result;
    	
//    	
//        String token = iamportApi.getImportToken();
//
//        HttpHeaders headers = new HttpHeaders();
//        headers.setContentType(MediaType.APPLICATION_JSON);
//        headers.setBearerAuth(token);
//        
//
//        JSONArray schedulesArray = new JSONArray();
//        JSONObject scheduleObject = new JSONObject();
////        scheduleObject.put("merchant_uid", merchantUid);
////        scheduleObject.put("amount", amount);
////        scheduleObject.put("currency", "KRW");
////        scheduleObject.put("name", "정기 구독 결제");
//        schedulesArray.put(scheduleObject);
//        
//        JSONObject requestObject = new JSONObject();
//        requestObject.put("customer_uid", customerUid);
//        requestObject.put("schedules", schedulesArray);
//        requestObject.put("merchant_uid", merchantUid);
//        requestObject.put("amount", amount);
//        
//        String requestBody = requestObject.toString();
//        
//        log.debug("requestBody = {}", requestBody);
//        
//        RestTemplate restTemplate = new RestTemplate();
//        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);
//
//        String result = restTemplate.postForObject(IMPORT_SCHEDULE_URL, entity, String.class);
//
//        log.debug("result = {}", result);
//
//        return result;
    }
}
