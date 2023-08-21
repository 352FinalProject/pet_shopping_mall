package com.shop.app.common.controller.advice;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EmailController {
	
	private final Map<String, String> tokenStore = new HashMap<>();
	
	// 인증 이메일 발송
	  @PostMapping("/email/send")
	  public Map<String, Object> sendEmail(@RequestBody Map<String, String> payload) {
		  
		log.debug("인증 이메일 발송 메소드 로드");
	    String email = payload.get("email");
	    
	    // 토큰 생성
	    String token = UUID.randomUUID().toString();
	    
	    // 이메일 발송 로직
	    MailSender mailSender = new MailSender();
	    mailSender.sendEmailOnUserVerification(email, token);
	    
	    // 토큰 저장
	    tokenStore.put(email, token);

	    Map<String, Object> response = new HashMap<>();
	    response.put("success", true);
	    return response;
	  }

	  // 인증 토큰 확인
	  @PostMapping("/email/verify")
	  public Map<String, Object> verifyToken(@RequestBody Map<String, String> payload) {
		log.debug("post 인증 이메일 인증 처리하는 메소드 로드");
	    String email = payload.get("email");
	    String token = payload.get("token");
	    
	    // 토큰 검증
	    String storedToken = tokenStore.get(email);
	    boolean isValid = token.equals(storedToken);
	    
	    Map<String, Object> response = new HashMap<>();
	    response.put("success", isValid);
	    log.debug("response = {}", response);
	    
	    return response;
	  }
	  
	  // 인증 처리 하는 링크
	  @GetMapping("/email/verifyEmail")
	  public ResponseEntity<String> verifyEmail(@RequestParam String email, @RequestParam String token) {
		  log.debug("get 인증 이메일 인증 처리하는 메소드 로드");
		  
	      // 토큰 검증 로직
	      String storedToken = tokenStore.get(email);
	      boolean isValid = token.equals(storedToken);
	      if (isValid) {
	          // 인증 완료 처리
	          return new ResponseEntity<>("Email verification success.", HttpStatus.OK);
	      } else {
	          return new ResponseEntity<>("Invalid verification token.", HttpStatus.BAD_REQUEST);
	      }
	  }

}
