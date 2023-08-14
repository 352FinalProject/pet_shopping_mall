package com.shop.app.servicecenter.inquiry.controller;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSender {

	    public void sendEmailOnAnswerRegistration(String userEmail, String answerContent) {
	        String subject = "문의하신 내용에 답변이 등록되었습니다.";
	        String message = "안녕하세요,\n\n문의하신 내용에 다음과 같은 답변이 등록되었습니다:\n\n" + answerContent;
	        
	        sendEmail(userEmail, subject, message);
	    }

	    // 실제 이메일 발송 처리 메소드
	    public void sendEmail(String recipient, String subject, String message) {
	        Properties p = System.getProperties();
	        p.put("mail.smtp.starttls.enable", "true");
	        p.put("mail.smtp.host", "smtp.naver.com");
	        p.put("mail.smtp.auth", "true");
	        p.put("mail.smtp.port", "25");

	        Authenticator auth = new MyAuthentication();
	        Session session = Session.getDefaultInstance(p, auth);
	        MimeMessage msg = new MimeMessage(session);

	        try {
	            msg.setSentDate(new Date());
	            InternetAddress from = new InternetAddress();
	            from = new InternetAddress("vldzmf0877@naver.com");
	            msg.setFrom(from);
	            InternetAddress to = new InternetAddress(recipient);
	            msg.setRecipient(Message.RecipientType.TO, to);
	            msg.setSubject(subject, "UTF-8");
	            msg.setText(message, "UTF-8");
	            msg.setHeader("content-Type", "text/html");
	            javax.mail.Transport.send(msg, msg.getAllRecipients());
	        } catch (AddressException addr_e) {
	            addr_e.printStackTrace();
	        } catch (MessagingException msg_e) {
	            msg_e.printStackTrace();
	        }
	    }

	    public static void main(String[] args) {
	        // 메인 메소드 내에서 객체 생성 및 이메일 발송 메소드 호출
	        MailSender mailSender = new MailSender();
	        mailSender.sendEmailOnAnswerRegistration("vldzmf0877@naver.com", "테스트");
	    }
	}
	
class MyAuthentication extends Authenticator {

	PasswordAuthentication pa;
	public MyAuthentication(){

		String id = "vldzmf0877@naver.com";  //네이버 이메일 아이디
		String pw = "dPfk7311!";        //네이버 비밀번호

		// ID와 비밀번호를 입력한다.
		pa = new PasswordAuthentication(id, pw);
	}

	// 시스템에서 사용하는 인증정보
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}
} 
