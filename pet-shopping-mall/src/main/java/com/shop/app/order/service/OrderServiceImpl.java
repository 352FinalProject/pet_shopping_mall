package com.shop.app.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.order.dto.OrderAdminListDto;
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
	
	@Override
	public List<OrderAdminListDto> adminOrderList() {
		return orderRepository.adminOrderList();
	}
}
