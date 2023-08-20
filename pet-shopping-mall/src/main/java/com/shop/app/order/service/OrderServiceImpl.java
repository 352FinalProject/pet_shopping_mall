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

	// 관리자페이지 주문조회 (대원)
	@Override
	public List<OrderAdminListDto> adminOrderList() {
		return orderRepository.adminOrderList();


	// 2. db에서 주문 정보 가져오기 (예라)
	@Override
	public Order findByOrder(Order order) {
		return orderRepository.findByOrder(order);

	}
}
