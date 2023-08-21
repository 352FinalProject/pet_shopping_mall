package com.shop.app.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.entity.Order;
import com.shop.app.order.entity.OrderDetail;
import com.shop.app.order.repository.OrderRepository;

public interface OrderService {

	int insertOrder(Order order, List<OrderDetail> orderDetails);

	// 2. db에서 주문 정보 가져오기 (예라)
	Order findByOrder(Order order);

	// 주문내역 조회 (담희)
	List<OrderHistoryDto> getOrderList(String memberId);

	// 미 결제시 주문 취소
	int insertCancelOrder(String orderNo);
	
}
