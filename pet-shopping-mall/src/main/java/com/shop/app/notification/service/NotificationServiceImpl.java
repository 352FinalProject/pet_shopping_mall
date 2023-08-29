package com.shop.app.notification.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.shop.app.notification.entity.Notification;
import com.shop.app.notification.repository.NotificationRepository;
import com.shop.app.payment.dto.PaymentCompleteNotificationDto;

@Service
public class NotificationServiceImpl implements NotificationService {
	@Autowired
	NotificationRepository notificationRepository;
	
	@Autowired
	SimpMessagingTemplate simpMessagingTemplate;
	
	/**
	 * 1. 실시간알림
	 * 2. notification db 저장
	 */
	@Override
	public int paymentCompleteNotification(PaymentCompleteNotificationDto paymentCompleteNotificationDto) {
		// 실시간 알림을 보낸다.
		// 1. 작성자의 구독자 조회
		// 2. 각 사용자에게 알림메세지 발송(stomp)
        String to = paymentCompleteNotificationDto.getMemberId();
        				
        Notification notification = Notification.builder()
            .id(paymentCompleteNotificationDto.getOrderId())
            .notiCategory(1)
            .notiContent(paymentCompleteNotificationDto.getProductName() + "상품 주문완료 되었습니다.")
            .notiCreatedAt(new Timestamp(System.currentTimeMillis()))
            .memberId(to) 
            .build();

		simpMessagingTemplate.convertAndSend("/pet/notice/" + to, notification);
		
		// 3. db 알림행 등록
		return notificationRepository.insertNotification(notification);
	}
	
	@Override // db에서 알림 가져오기
	public List<Notification> findAllNotification(String memberId) {
		return notificationRepository.findAllNotification(memberId);
	}
}
