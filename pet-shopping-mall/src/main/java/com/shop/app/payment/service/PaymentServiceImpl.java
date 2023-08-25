package com.shop.app.payment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.cart.repository.CartRepository;
import com.shop.app.order.entity.Order;
import com.shop.app.order.repository.OrderRepository;
import com.shop.app.payment.entity.Payment;
import com.shop.app.payment.repository.PaymentRepository;

@Service
public class PaymentServiceImpl implements PaymentService {
	
	@Autowired
	CartRepository cartRepository;
	
	@Autowired
	PaymentRepository paymentRepository;
	
	@Autowired
	OrderRepository orderRepository;
	
	@Override
	public int updatePayStatus(String orderNo) {
		
		Order order = orderRepository.findOrderByOrderNo(orderNo);
		Payment payment = Payment.builder()
				.orderId(order.getOrderId())
				.amount(order.getAmount())
				.build();
		int result = paymentRepository.insertPayment(payment);
		result =  paymentRepository.updatePayStatus(orderNo);
		result = orderRepository.updateOrderStatus(orderNo, 1);
		// 장바구니 비우기
		result= cartRepository.deleteCartAll(order.getMemberId());
		
		if(result == 1) {
			return 1;
		} else {
			return 0;
		}
		
	}

}
