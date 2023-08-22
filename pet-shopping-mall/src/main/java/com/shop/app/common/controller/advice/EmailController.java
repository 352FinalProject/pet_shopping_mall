package com.shop.app.common.controller.advice;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EmailController {
	
	private final Map<String, String> tokenStore = new HashMap<>();
	
	// 인증 이메일 발송
	  @PostMapping("/email/send")
	  public Map<String, Object> sendEmail(@RequestBody Map<String, String> payload, HttpSession session) {
	    String email = payload.get("email");
	    
	    // 토큰 생성
	    String token = UUID.randomUUID().toString();
	    
	    // 이메일 발송 로직
	    MailSender mailSender = new MailSender();
	    mailSender.sendEmailOnUserVerification(email, token);
	    
	    // 토큰 저장
	    tokenStore.put(email, token);
	    
	    // 세션에 인증 정보 저장
	    session.setAttribute("emailVerified", true);

	    Map<String, Object> response = new HashMap<>();
	    response.put("success", true);
	    log.debug("Response being sent: " + response);
	    return response;
	  }

	  // 인증 처리 하는 링크
	  @GetMapping("/email/verifyEmail")
	  public ResponseEntity<String> verifyEmail(@RequestParam String email, @RequestParam String token) {
		  
	      // 토큰 검증 로직
	      String storedToken = tokenStore.get(email);
	      boolean isValid = token.equals(storedToken);
	      if (isValid) {
	          // 인증 완료 처리
	          return new ResponseEntity<>("이메일 인증이 완료되었습니다.", HttpStatus.OK);
	      } else {
	          return new ResponseEntity<>("이메일 인증이 실패했습니다.", HttpStatus.BAD_REQUEST);
	      }
	  }

}
