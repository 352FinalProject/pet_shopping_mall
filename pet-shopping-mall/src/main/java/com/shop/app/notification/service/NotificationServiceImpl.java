package com.shop.app.notification.service;

import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.shop.app.order.dto.OrderCompleteNotificationDto;
import com.shop.app.ws.dto.Payload;

@Service
public class NotificationServiceImpl implements NotificationService {
	
	@Autowired
	SimpMessagingTemplate simpMessagingTemplate;
	
	/**
	 * 1. 실시간알림
	 * 2. notification db 저장
	 */
	@Override
	public int notifyOrderComplete(OrderCompleteNotificationDto orderCompleteNotificationDto ) {
		// board 작성자의 구독자에게 실시간 알림을 보낸다.
		// 1. 작성자의 구독자 조회
		// 2. 각 사용자에게 알림메세지 발송(stomp)
        String to = orderCompleteNotificationDto.getMemberId();

        Payload payload = Payload.builder()
            .id(orderCompleteNotificationDto.getOrderId())
            .notiCategory(1)
            .notiContent(orderCompleteNotificationDto.getProductName() + "상품 주문완료 되었습니다.")
            .notiCreatedAt(new Timestamp(System.currentTimeMillis()))
            .memberId(to) 
            .build();

		
		simpMessagingTemplate.convertAndSend("/app/notice/" + to, payload);
		
		// 3. db 알림행 등록
		return 0;
	}
}
