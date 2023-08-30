package com.shop.app.payment.service;

import java.util.List;

import com.shop.app.payment.dto.PaymentCompleteNotificationDto;
import com.shop.app.payment.entity.Payment;


public interface PaymentService {
	
	int updatePayStatus(String orderNo, String pgProvider);
	
	int insertPayment(Payment payment);
	
	Payment getPaymentInfo(int orderId);

	int insertSubPayment(String customerUid);
	
	// 알림 (productName가져오기위한 메서드 - 대원)
	PaymentCompleteNotificationDto notificationFindOrderByOrderNo(String orderNo);

}
