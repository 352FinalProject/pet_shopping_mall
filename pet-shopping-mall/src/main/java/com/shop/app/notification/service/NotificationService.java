package com.shop.app.notification.service;

import com.shop.app.order.dto.OrderCompleteNotificationDto;
import com.shop.app.order.dto.OrderHistoryDto;

public interface NotificationService {

	int notifyOrderComplete(OrderCompleteNotificationDto orderCompleteNotificationDto);

}
