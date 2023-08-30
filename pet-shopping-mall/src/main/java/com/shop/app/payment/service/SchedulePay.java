package com.shop.app.payment.service;

import java.sql.Timestamp;
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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.shop.app.member.entity.SubMember;
import com.shop.app.member.repository.MemberRepository;
import com.shop.app.member.service.MemberService;
import com.shop.app.payment.controller.IamportApi;
import com.shop.app.payment.dto.ApiResponse;
import com.sun.source.tree.MemberReferenceTree;

import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;

@Slf4j
@Service
public class SchedulePay {
	
	@Autowired
	private IamportApi iamportApi;
	
	@Autowired
	MemberService memberService;
	
	public static final String IMPORT_SCHEDULE_URL = "https://api.iamport.kr/subscribe/payments/schedule";
	public static final String IMPORT_UNSCHEDULE_URL = "https://api.iamport.kr/subscribe/payments/unschedule";

	
	@Autowired
	MemberRepository memberRepository;
	
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
    	scheduleMap.put("merchant_uid", "membership" + scheduleAtTimestampSeconds);

    	List<Map<String, Object>> schedulesList = new ArrayList<>();
    	schedulesList.add(scheduleMap);

    	Map<String, Object> requestMap = new HashMap<>();
    	requestMap.put("customer_uid", customerUid);
    	requestMap.put("schedules", schedulesList);

    	String requestBody;
    	
    	try {
    	    requestBody = objectMapper.writeValueAsString(requestMap);
    	} catch (Exception e) {
    	    return "json 형변환 실패";
    	}

    	RestTemplate restTemplate = new RestTemplate();

    	HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

    	String result = restTemplate.postForObject(IMPORT_SCHEDULE_URL, entity, String.class);
    	
    	
    	SubMember newSubMember = new SubMember();
    	try {
    	    Map<String, Object> responseMap = objectMapper.readValue(result, new TypeReference<Map<String, Object>>() {});
    	    List<Map<String, Object>> responseList = (List<Map<String, Object>>) responseMap.get("response");

    	    for (Map<String, Object> subMemberMap : responseList) {
    	        Integer unixTimestamp = (Integer) subMemberMap.get("schedule_at");
    	        
    	        Timestamp scheduleAtTimestamp = new Timestamp(unixTimestamp * 1000L);
    	        
    	        String _memberId = (String) subMemberMap.get("customer_uid");
    	        String _merchantUid = (String) subMemberMap.get("merchant_uid");
    	        String _scheduleStatus = (String) subMemberMap.get("schedule_status");
    	        int _amount = (int) subMemberMap.get("amount");

    	        // 위에서 추출한 값들로 SubMember 객체를 생성하고 DB에 저장
    	        newSubMember.setScheduleAt(scheduleAtTimestamp);
    	        newSubMember.setMemberId(_memberId);
    	        newSubMember.setMerchantUid(_merchantUid);
    	        newSubMember.setScheduleStatus(_scheduleStatus);
    	        newSubMember.setAmount(_amount);

    	        memberRepository.insertSubMember(newSubMember);
    	    }
    	    return "성공!";
    	    
    	} catch (Exception e) {
    	    e.printStackTrace();
    	    return "예외발생!";
    	}
    }
    
    
    

	public String cancelSchedule(SubMember subMember) {
    	String token = iamportApi.getImportToken();

    	HttpHeaders headers = new HttpHeaders();
    	headers.setContentType(MediaType.APPLICATION_JSON);
    	headers.setBearerAuth(token);
    	
    	Map<String, Object> unScheduleMap = new HashMap<>();
    	unScheduleMap.put("customer_uid", subMember.getMemberId());
    	unScheduleMap.put("merchant_uid", subMember.getMerchantUid());
    	
    	String requestBody;
    	
    	try {
    	    requestBody = objectMapper.writeValueAsString(unScheduleMap);
    	} catch (Exception e) {
    	    return "json 형변환 실패";
    	}
    	
    	RestTemplate restTemplate = new RestTemplate();
    	
    	HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

    	String result = restTemplate.postForObject(IMPORT_UNSCHEDULE_URL, entity, String.class);
    	
    	log.debug(result);
    	
    	// 스케쥴이 지나면 sub_member 테이블에서 삭제하기
    	// member 테이블에서 구독 N 처리
    	String memberId = subMember.getMemberId();
    	// memberService.cancelSubscribe(memberId);

    	
    	
    	
    	
    	
		return result;
	}
}
