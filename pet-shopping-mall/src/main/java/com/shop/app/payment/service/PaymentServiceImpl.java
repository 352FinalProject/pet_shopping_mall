package com.shop.app.payment.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.order.repository.OrderRepository;
import com.shop.app.payment.repository.PaymentRepository;

@Service
public class PaymentServiceImpl implements PaymentService {
	
	@Autowired
	PaymentRepository paymentRepository;
	
	@Autowired
	OrderRepository orderRepository;
	
	@Override
	public int updatePayStatus(String orderNo) {
		// 결제가 완료되면 결제 상태 업데이트
		int result =  paymentRepository.updatePayStatus(orderNo);
		
		// 주문 테이블의 주문 상태 업데이트
		int result2 = orderRepository.updateOrderStatus(orderNo, 1);
		
		if(result == 1 && result2 == 1) {
			return 1;
		} else {
			return 0;
		}
		
	}
}
