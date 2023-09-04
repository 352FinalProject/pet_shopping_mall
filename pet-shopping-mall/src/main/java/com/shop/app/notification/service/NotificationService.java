package com.shop.app.notification.service;

import java.util.List;

import com.shop.app.notification.entity.Notification;
import com.shop.app.payment.dto.PaymentCompleteNotificationDto;

public interface NotificationService {

	List<Notification> findAllNotification(String memberId);

	int updateOrderStatusNotification();

	int deleteNotification(int id);



}
