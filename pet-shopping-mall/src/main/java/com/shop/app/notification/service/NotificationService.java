package com.shop.app.notification.service;

import com.shop.app.notification.entity.Notification;
import com.shop.app.payment.dto.PaymentCompleteNotificationDto;

public interface NotificationService {

	int paymentCompleteNotification(PaymentCompleteNotificationDto paymentCompleteNotificationDto);



}
