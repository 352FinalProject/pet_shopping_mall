package com.shop.app.notification.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.sh.app.board.entity.BoardDetails;
import com.sh.app.ws.dto.Payload;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NotificationServiceImpl implements NotificationService {
	
	@Autowired
	SimpMessagingTemplate simpMessagingTemplate;
	
	/**
	 * 1. 실시간알림
	 * 2. notification db 저장
	 */
	@Override
	public int notifyBoardCreate(BoardDetails board) {
		// board 작성자의 구독자에게 실시간 알림을 보낸다.
		// 1. 작성자의 구독자 조회
		// 2. 각 사용자에게 알림메세지 발송(stomp)
		String to = "sinsa";
		Payload payload = Payload.builder()
				.to(to)
				.content(board.getMemberId() + "가 새글을 게시했습니다. : " + board.getTitle())
				.createdAt(System.currentTimeMillis())
				.build();
		
		simpMessagingTemplate.convertAndSend("/app/notice/" + to, payload);
		
		// 3. db 알림행 등록
		return 0;
	}
}
