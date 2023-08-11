package com.shop.app.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.order.repository.OrderRepository;

//@Service
public class OrderServiceImpl implements OrderService {
	
//	@Autowired
	private OrderRepository orderRepository;
}
