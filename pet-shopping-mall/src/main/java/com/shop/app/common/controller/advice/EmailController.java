package com.shop.app.common.controller.advice;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.app.member.entity.Member;
import com.shop.app.member.repository.MemberRepository;
import com.shop.app.member.service.MemberService;
import com.shop.app.member.service.MemberServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EmailController {

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	MemberService memberService;
	
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

	// 이메일로 임시 비밀번호 발송하는 메소드 추가
	@PostMapping("/email/sendTemporaryPassword.do")
	public ResponseEntity<String> sendTemporaryPassword(@RequestParam String email, HttpSession session) {
		// 임시 비밀번호 생성
		String temporaryPassword = generateTemporaryPassword(10); // 10자리의 임시 비밀번호 생성

		// 이메일 전송 로직
		MailSender mailSender = new MailSender();
		mailSender.sendTemporaryPasswordEmail(email, temporaryPassword);

		// 임시 비밀번호 저장
		tokenStore.put(email, temporaryPassword);
		Member member = memberService.findByEmail(email);
		
		log.debug("temporaryPassword = {}", temporaryPassword);
		
		String encodedPassword = passwordEncoder.encode(temporaryPassword);
		
		log.debug("encodedPassword = {}", encodedPassword);
		
		if (member != null) {
			member.setPassword(passwordEncoder.encode(temporaryPassword));
			memberService.updateMember(member); // 데이터베이스 업데이트
		}

		// 세션에 임시 비밀번호 발송 완료 상태 저장
		session.setAttribute("temporaryPasswordSent", true);

	    return ResponseEntity.status(HttpStatus.OK)
                .header("Location", "/member/myPage.do")  // 여기서 "/my-page"는 실제 리디렉션할 URL로 변경해야 합니다.
                .body("임시 비밀번호가 성공적으로 전송되었습니다. 내 페이지로 이동합니다.");
	
	}

	private String generateTemporaryPassword(int length) {
	    // 임시 비밀번호에 포함될 문자들
	    String allowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	    
	    // 임시 비밀번호를 저장할 변수 초기화
	    StringBuilder temporaryPassword = new StringBuilder();
	    
	    // 지정한 길이만큼 랜덤한 문자를 임시 비밀번호에 추가
	    for (int i = 0; i < length; i++) {
	        int randomIndex = (int) (Math.random() * allowedCharacters.length());
	        char randomChar = allowedCharacters.charAt(randomIndex);
	        temporaryPassword.append(randomChar);
	    }
	    
	    String newPassword = temporaryPassword.toString();
	    return newPassword;
	}

}
