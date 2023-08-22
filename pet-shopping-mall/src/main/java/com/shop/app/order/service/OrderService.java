package com.shop.app.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.shop.app.order.dto.OrderAdminListDto;
import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.entity.Order;
import com.shop.app.order.entity.OrderDetail;
import com.shop.app.order.repository.OrderRepository;

public interface OrderService {

	int insertOrder(Order order, List<OrderDetail> orderDetails);

	// 관리자페이지 주문조회(대원)
	List<OrderAdminListDto> adminOrderList();

	// 2. db에서 주문 정보 가져오기 (예라)
	Order findByOrder(Order order);

	// 주문내역 조회 (담희)
	List<OrderHistoryDto> getOrderList(String memberId);

	// 주문 취소
	int insertCancelOrder(String orderNo, String isRefund);

	List<OrderHistoryDto> getOrderListByPeriod(String memberId, int period);

	List<OrderAdminListDto> adminOrderSearch(String searchKeyword, String startDate, String endDate,
			List<String> paymentMethod, List<String> orderStatus);

	
}
