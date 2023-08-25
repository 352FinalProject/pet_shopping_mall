package com.shop.app.ws.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.shop.app.member.service.MemberService;
import com.shop.app.ws.dto.Payload;

import lombok.extern.slf4j.Slf4j;

/**
 * ApplicationDestinationPrefix로 시작하는 ws 요청은 이 핸들러를 거친다.
 *
 */
@Controller
@Slf4j
public class StompMessageController {
	
	@Autowired
	private MemberService memberService;
	/**
	 * prefix를 제외한 url만 작성
	 */
	@MessageMapping("/notice")
	@SendTo("/app/notice")
	public Payload a(Payload message) {
		log.debug("message = {}", message);
		// notificationService.insertNotification(message);
		return message;
	}
	
	@MessageMapping("/notice/{memberId}")
	@SendTo("/app/notice/{memberId}")
	public Payload noticeEach(@DestinationVariable String memberId, Payload message) {
		log.debug("memberId = {}", memberId);
		log.debug("message = {}", message);
		return message;
	}
	
}
