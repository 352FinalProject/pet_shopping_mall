package com.shop.app.payment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.cart.repository.CartRepository;
import com.shop.app.member.repository.MemberRepository;
import com.shop.app.order.entity.Order;
import com.shop.app.order.repository.OrderRepository;
import com.shop.app.payment.dto.PaymentCompleteNotificationDto;
import com.shop.app.payment.entity.Payment;
import com.shop.app.payment.repository.PaymentRepository;

@Transactional(rollbackFor = Exception.class)
@Service
public class PaymentServiceImpl implements PaymentService {
	
	@Autowired
	CartRepository cartRepository;
	
	@Autowired
	PaymentRepository paymentRepository;
	
	@Autowired
	OrderRepository orderRepository;
	
	@Autowired
	MemberRepository memberRepository;
	
	
	
	/**
	 * @author 김담희
	 * 결제가 완료되면 결제 테이블에 insert
	 * 주문 테이블 주문 상태 변경 (0이 결제완료)
	 * 결제 완료 여부 업데이트
	 * 장바구니 전체 비우기
	 */
	@Override
	public int updatePayStatus(String orderNo, String pgProvider) {
		
		Order order = orderRepository.findOrderByOrderNo(orderNo);
		Payment payment = Payment.builder()
				.orderId(order.getOrderId())
				.amount(order.getAmount())
				.build();
		
		int result  = 0;
		
		if(pgProvider.equals("kakaopay")) {
			payment.setPaymentMethod(1);
			result = paymentRepository.insertPayment(payment);
		} else {
			payment.setPaymentMethod(0);
			result = paymentRepository.insertPayment(payment);
			
		}
		result = orderRepository.updateOrderStatus(orderNo, 0);
		
		result =  paymentRepository.updatePayStatus(orderNo);
		result= cartRepository.deleteCartAll(order.getMemberId());
		
		if(result == 1) {
			return 1;
		} else {
			return 0;
		}
		
	}

	@Override
	public int insertPayment(Payment payment) {
		return paymentRepository.insertPayment(payment);
	}

	@Override
	public Payment getPaymentInfo(int orderId) {
		return paymentRepository.getPaymentInfo(orderId);
	}
	
	
	/**
	 * @author 김담희
	 * 구독자 결제 테이블에 결제 정보 저장
	 */
	@Override
	public int insertSubPayment(String customerUid) {
		int result = memberRepository.memberSubscribe(customerUid);
		result =  paymentRepository.insertSubPayment(customerUid);
		return result;
	}
	
	
	
	// 알림 (productName가져오기위한 메서드 - 대원)
	@Override
	public PaymentCompleteNotificationDto notificationFindOrderByOrderNo(String orderNo) {
		return paymentRepository.notificationFindOrderByOrderNo(orderNo);
	}
}
