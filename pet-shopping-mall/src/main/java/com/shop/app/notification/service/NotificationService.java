package com.shop.app.notification.service;

import com.shop.app.notification.entity.Notification;
import com.shop.app.order.dto.OrderCompleteNotificationDto;

public interface NotificationService {

	int notifyOrderCreate(OrderCompleteNotificationDto orderCompleteNotificationDto); 



}
