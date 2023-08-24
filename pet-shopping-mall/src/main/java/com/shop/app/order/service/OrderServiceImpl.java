package com.shop.app.order.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.info.ProjectInfoProperties.Build;
import org.springframework.stereotype.Service;

import com.shop.app.order.dto.OrderAdminListDto;
import com.shop.app.order.dto.OrderCancelInfoDto;
import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.entity.CancelOrder;
import com.shop.app.order.entity.Order;
import com.shop.app.order.entity.OrderDetail;
import com.shop.app.order.repository.OrderRepository;
import com.shop.app.payment.entity.Payment;
import com.shop.app.payment.repository.PaymentRepository;

import lombok.Builder;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private PaymentRepository paymentRepository;
	
	
	@Autowired
	private OrderRepository orderRepository;

	// 주문 내역 및 주문 상세내역 테이블에 저장 (담희)
	@Override
	public int insertOrder(Order order, List<OrderDetail> orderDetails) {
		int result = 0;
		result = orderRepository.insertOrder(order);
		int orderId = order.getOrderId();
		
		// 주문 상세내역에 넣기
		for(OrderDetail orderDetail : orderDetails) {
			orderDetail.setOrderId(orderId);
			result = orderRepository.insertOrderDetail(orderDetail);
		}
		return result;
	}

	// 관리자페이지 주문조회 (대원)
	@Override
	public List<OrderAdminListDto> adminOrderList() {
		return orderRepository.adminOrderList();
	}
	// 관리자페이지 주문검색 조회 (대원)
	@Override
	public List<OrderAdminListDto> adminOrderSearch(String searchKeyword, String startDate, String endDate,
			List<String> paymentMethod, List<String> orderStatus) {
		return orderRepository.adminOrderSearch(searchKeyword, startDate, endDate, paymentMethod, orderStatus);
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
	public int insertCancelOrder(String orderNo, String isRefund) {
		int result = 0;
		Order order = orderRepository.findOrderByOrderNo(orderNo);
		
		int orderId = order.getOrderId();
		CancelOrder cancel = CancelOrder.builder()
				.orderId(orderId)
				.build();
		result = orderRepository.insertCancelOrder(cancel);
		
		if(isRefund.equals("N")) 
			result = orderRepository.updateOrderStatus(orderNo, 5);
		else if(isRefund.equals("Y"))
			result = orderRepository.updateOrderStatus(orderNo, 6);
			
		return result;
	}

	@Override
	public List<OrderHistoryDto> getOrderListByPeriod(String memberId, int period) {
		return orderRepository.getOrderListByPeriod(memberId, period);
	}

	@Override
	public OrderCancelInfoDto getCancelInfo(String orderNo) {
		return orderRepository.getCancelInfo(orderNo);
	}

	@Override
	public List<OrderCancelInfoDto> getCancelInfoAll(String memberId) {
		return orderRepository.getCancelInfoAll(memberId);
	}

	@Override
	public List<OrderCancelInfoDto> getCancelInfoByPeriod(String memberId, int period) {
		return orderRepository.getCancelInfoByPeriod(memberId, period);
	}

	@Override
	public int deleteOrder(String orderNo) {
		return orderRepository.deleteOrder(orderNo);
	}

	@Override
	public Map<OrderHistoryDto, Payment> getOrderDetail(String orderNo) {
		Map<OrderHistoryDto, Payment> orderDetailMap = new HashMap<>();
		OrderHistoryDto history = orderRepository.getOrderDetail(orderNo);
		Payment payment = paymentRepository.getPaymentInfo(history.getOrderId());
		orderDetailMap.put(history, payment);
		return orderDetailMap;
	}
}
