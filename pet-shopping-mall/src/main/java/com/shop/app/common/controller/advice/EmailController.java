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
import org.springframework.web.bind.annotation.ResponseBody;

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

   @Autowired
   MailSender mailSender;
   
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

   @ResponseBody
   @GetMapping("/email/findMemberIdByEmail.do")
   public String findMemberIdByEmail(@RequestParam String email) {
      Member member = memberService.findByEmail(email);
      if (member == null) {
         return "not_found";
      } else {
         return member.getMemberId(); // 회원의 ID를 반환합니다.
      }
   }

	// 이메일로 임시 비밀번호 발송하는 메소드 추가
	@PostMapping("/email/sendTemporaryPassword.do")
	public ResponseEntity<String> sendTemporaryPassword(@RequestParam String email, HttpSession session) {
		// 이메일 전송 로직
		MailSender mailSender = new MailSender();
		String temporaryPassword = mailSender.generateTemporaryPassword(10);
		
		mailSender.sendTemporaryPasswordEmail(email, temporaryPassword); 
		
		// 임시 비밀번호 저장
		tokenStore.put(email, temporaryPassword);
		Member member = memberService.findByEmail(email);
		
		
		String encodedPassword = passwordEncoder.encode(temporaryPassword);
		
		
		if (member != null) {
			member.setPassword(passwordEncoder.encode(temporaryPassword));
			memberService.updateMember(member); // 데이터베이스 업데이트
		}

		// 세션에 임시 비밀번호 발송 완료 상태 저장
		session.setAttribute("temporaryPasswordSent", true);

	    return ResponseEntity.status(HttpStatus.OK)
               .header("Location", "/member/myPage.do")  // 여기서 "/my-page"는 실제 리디렉션할 URL로 변경해야 합니다.
               .body("0");
	}

}