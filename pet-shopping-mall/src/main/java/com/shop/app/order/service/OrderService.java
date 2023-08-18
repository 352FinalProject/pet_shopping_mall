package com.shop.app.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.shop.app.order.dto.OrderAdminListDto;
import com.shop.app.order.entity.Order;
import com.shop.app.order.repository.OrderRepository;

public interface OrderService {

	int insertOrder(Order order);

	List<OrderAdminListDto> adminOrderList();
	
	
}
