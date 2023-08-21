package com.shop.app.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.info.ProjectInfoProperties.Build;
import org.springframework.stereotype.Service;

import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.entity.CancelOrder;
import com.shop.app.order.entity.Order;
import com.shop.app.order.entity.OrderDetail;
import com.shop.app.order.repository.OrderRepository;

import lombok.Builder;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderRepository orderRepository;

	// 주문 내역 및 주문 상세내역 테이블에 저장 (담희)
	@Override
	public int insertOrder(Order order, List<OrderDetail> orderDetails) {
		int result = 0;
		// 주문 테이블에 넣기
		result = orderRepository.insertOrder(order);
		int orderId = order.getOrderId();
		
		log.debug("orderId = {}", orderId); // 0이 떠요
		
		// 주문 상세내역에 넣기
		for(OrderDetail orderDetail : orderDetails) {
			orderDetail.setOrderId(orderId);
			result = orderRepository.insertOrderDetail(orderDetail);
		}
		return result;
	}

	// 2. db에서 주문 정보 가져오기 (예라)
	@Override
	public Order findByOrder(Order order) {
		return orderRepository.findByOrder(order);
	}

	@Override
	public List<OrderHistoryDto> getOrderList(String memberId) {
		return orderRepository.getOrderList(memberId);
	}

	@Override
	public int insertCancelOrder(String orderNo) {
		int result = 0;
		
		Order order = orderRepository.findOrderByOrderNo(orderNo);
		
		int orderId = order.getOrderId();
		CancelOrder cancel = CancelOrder.builder()
				.orderId(orderId)
				.build();
		
		result = orderRepository.insertCancelOrder(cancel);
		result = orderRepository.updateOrderStatus(orderNo, 5);
		return result;
	}
}
