package com.shop.app.ws.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.shop.app.member.service.MemberService;
import com.shop.app.notification.entity.Notification;
import com.shop.app.notification.service.NotificationService;

import lombok.extern.slf4j.Slf4j;

/**
 * ApplicationDestinationPrefix로 시작하는 ws 요청은 이 핸들러를 거친다.
 */
@Controller
@Slf4j
public class StompMessageController {
   
   // STOMP (Simple Text Oriented Messaging Protocol)
   // 간단한 메시지를 전송하기 위한 프로토콜로 메시지 브로커를와 publisher - subscriber 방식을 사용
   // 메세지 브로커는 발행자가 보낸 메세지를 구독자에게 전달해주는 역할
   
   @Autowired
   private MemberService memberService; // 빈 생성 가능
			   // 디비에서 조회해서 메세지로 출력도 가능하다는 의미
   
   @Autowired
   private NotificationService notificationService;
   
	@MessageMapping("/notice")
	@SendTo("/pet/notice")
	public Notification a(Notification message) {
		log.debug("message = {}", message);
		return message;
}
   
   /**
    * 개개인에게
    */
   @MessageMapping("/notice/{memberId}")
   @SendTo("/pet/notice/{memberId}")
   public Notification noticeEach(@DestinationVariable String memberId, Notification message) {
                        // 경로변수
      log.debug("memberId = {}", memberId);
      log.debug("message = {}", message);
      
      System.out.println("message: "  + message);
      return message;
   }
}