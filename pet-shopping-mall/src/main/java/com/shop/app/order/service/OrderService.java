package com.shop.app.order.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.shop.app.order.entity.Order;
import com.shop.app.order.repository.OrderRepository;

public interface OrderService {

	int insertOrder(Order order);

	// 2. db에서 주문 정보 가져오기 (예라)
	Order findByOrder(Order order);
	
	
}
