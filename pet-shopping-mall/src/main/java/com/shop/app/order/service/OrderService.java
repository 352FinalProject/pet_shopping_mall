package com.shop.app.order.service;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;

import com.shop.app.order.dto.OrderAdminListDto;
import com.shop.app.order.dto.OrderAdminProductStatisticsDto;
import com.shop.app.order.dto.OrderAdminStatisticsByDateDto;
import com.shop.app.order.dto.OrderCancelInfoDto;
import com.shop.app.order.dto.OrderCreateDto;
import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.entity.Order;
import com.shop.app.order.entity.OrderDetail;
import com.shop.app.order.repository.OrderRepository;
import com.shop.app.payment.entity.Payment;

public interface OrderService {

	int insertOrder(Order order, List<OrderDetail> orderDetails);

	// 관리자페이지 주문조회(대원)
	List<OrderAdminListDto> adminOrderList();

	// 2. db에서 주문 정보 가져오기 (예라)
	Order findByOrder(Order order);

	// 주문내역 조회 (담희)
	List<Order> getOrderList(String memberId);

	// 주문 취소
	int insertCancelOrder(String orderNo, String isRefund);

	List<Order> getOrderListByPeriod(String memberId, int period);


	List<OrderAdminListDto> adminOrderSearch(String searchKeyword, String startDate, String endDate,
			List<String> paymentMethod, List<String> orderStatus);

	// 주문 취소 내역 조회
	OrderCancelInfoDto getCancelInfo(String orderNo);

	List<OrderCancelInfoDto> getCancelInfoAll(String memberId);

	List<OrderCancelInfoDto> getCancelInfoByPeriod(String memberId, int period);
	
	// 관리자페이지 상품매출통계 조회 - 판매수량 (대원)
	List<OrderAdminProductStatisticsDto> adminStatisticsProduct();

	// 관리자페이지 상품매출통계 조회 - 매출액(대원)
	List<OrderAdminProductStatisticsDto> adminStatisticsPrice();

	// 관리자페이지 날짜별매출통계 조회 - 일별(대원)
	List<OrderAdminStatisticsByDateDto> adminStatisticsByDaily();

	// 관리자페이지 날짜별매출통계 조회 - 월별(대원)
	List<OrderAdminStatisticsByDateDto> adminStatisticsByMonthly();

	int deleteOrder(String orderNo);

	List<Map<OrderHistoryDto, Payment>> getOrderDetail(String orderNo);

	Order findOrderByOrderNo(String orderNo);

	// 리뷰 작성하면 리뷰버튼 없애기 (예라)
	boolean reviewWrite(String memberId, int orderId);
	

	// 상품별 주문확정 주문 수 조회 (수경)
	int findOrderCntByProductId(int productDetailId);

	int updateOrderStatusIfExpired();

	
}
