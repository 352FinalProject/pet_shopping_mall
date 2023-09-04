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

   /**
    * @author 전예라
    * 이메일 인증 메일 발송
    */
   @PostMapping("/email/send")
   public Map<String, Object> sendEmail(@RequestBody Map<String, String> payload, HttpSession session) {
      String email = payload.get("email");

      String token = UUID.randomUUID().toString(); 

      MailSender mailSender = new MailSender();
      mailSender.sendEmailOnUserVerification(email, token);
      tokenStore.put(email, token);
      session.setAttribute("emailVerified", true);

      Map<String, Object> response = new HashMap<>();
      response.put("success", true);
      return response;
   }

   /**
    * @author 전예라
    * 이메일 인증 처리
    */
   @GetMapping("/email/verifyEmail")
   public ResponseEntity<String> verifyEmail(@RequestParam String email, @RequestParam String token) {

      String storedToken = tokenStore.get(email);
      boolean isValid = token.equals(storedToken);
      if (isValid) {
         return new ResponseEntity<>("이메일 인증이 완료되었습니다.", HttpStatus.OK);
      } else {
         return new ResponseEntity<>("이메일 인증이 실패했습니다.", HttpStatus.BAD_REQUEST);
      }
   }

   /**
    * @author 김상훈
    * 이메일 발송 전 아이디 찾기
    */
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
   
   
   /**
    * @author 김상훈
    * 임시비밀번호가 담긴 이메일 전송
    */
	@PostMapping("/email/sendTemporaryPassword.do")
	public ResponseEntity<String> sendTemporaryPassword(@RequestParam String email, HttpSession session) {
		
		MailSender mailSender = new MailSender();
		String temporaryPassword = mailSender.generateTemporaryPassword(10);
		
		mailSender.sendTemporaryPasswordEmail(email, temporaryPassword); 
		
		tokenStore.put(email, temporaryPassword);
		Member member = memberService.findByEmail(email);
		
		
		String encodedPassword = passwordEncoder.encode(temporaryPassword);
		
		
		if (member != null) {
			member.setPassword(passwordEncoder.encode(temporaryPassword));
			memberService.updateMember(member);
		}

		session.setAttribute("temporaryPasswordSent", true);

		return ResponseEntity.status(HttpStatus.FOUND)
			       .header("Location", "/pet/member/memberLogin.do")
			       .body("0");
	}

}