package com.shop.app.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.order.entity.Order;
import com.shop.app.order.repository.OrderRepository;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderRepository orderRepository;

	@Override
	public int insertOrder(Order order) {
		return orderRepository.insertOrder(order);
	}

	// 2. db에서 주문 정보 가져오기 (예라)
	@Override
	public Order findByOrder(Order order) {
		return orderRepository.findByOrder(order);
	}
}
