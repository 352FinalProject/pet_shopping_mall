package com.shop.app.order.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.info.ProjectInfoProperties.Build;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.order.dto.OrderAdminListDto;
import com.shop.app.order.dto.OrderAdminProductStatisticsDto;
import com.shop.app.order.dto.OrderAdminStatisticsByDateDto;
import com.shop.app.order.dto.OrderCancelInfoDto;
import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.dto.OrderReviewListDto;
import com.shop.app.order.entity.CancelOrder;
import com.shop.app.order.entity.Order;
import com.shop.app.order.entity.OrderDetail;
import com.shop.app.order.repository.OrderRepository;
import com.shop.app.payment.entity.Payment;
import com.shop.app.payment.repository.PaymentRepository;

import lombok.Builder;
import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Slf4j
@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private PaymentRepository paymentRepository;
	
	
	@Autowired
	private OrderRepository orderRepository;
	
	

	/**
	 * @author 김담희
	 * 주문 테이블과 주문 상세 테이블에 내역 저장
	 */
	@Override
	public int insertOrder(Order order, List<OrderDetail> orderDetails) {
		int result = 0;
		result = orderRepository.insertOrder(order);
		int orderId = order.getOrderId();
		
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
	
	
	// 관리자페이지 상품매출통계 조회 - 판매수량 (대원)
	@Override
	public List<OrderAdminProductStatisticsDto> adminStatisticsProduct() {
		return orderRepository.adminStatisticsProduct();
	}
	
	
	// 관리자페이지 상품매출통계 조회 - 매출액(대원)
	@Override
	public List<OrderAdminProductStatisticsDto> adminStatisticsPrice() {
		return orderRepository.adminStatisticsPrice();
	}
	
	
	// 관리자페이지 날짜별 상품매출통계 조회 - 일별 (대원)
	@Override
	public List<OrderAdminStatisticsByDateDto> adminStatisticsByDaily() {
		return orderRepository.adminStatisticsByDaily();
	}
	
	
	// 관리자페이지 날짜별 상품매출통계 조회 -월별 (대원)
	@Override
	public List<OrderAdminStatisticsByDateDto> adminStatisticsByMonthly() {
		return orderRepository.adminStatisticsByMonthly();
	}
	
	@Override
	public Order findByOrder(Order order) {
		return orderRepository.findByOrder(order);
	}
	

	@Override
	public List<Order> getOrderList(String memberId, Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return orderRepository.getOrderList(memberId, rowBounds);
	}


	/**
	 * @author 김담희
	 * 주문 취소 시 주문 취소 테이블에 insert
	 * 주문 테이블에서 주문 상태를 주문 취소 상태로 변경
	 */
	@Override
	public int insertCancelOrder(String orderNo, String isRefund) {
		int result = 0;
		Order order = orderRepository.findOrderByOrderNo(orderNo);
		int orderId = order.getOrderId();
		CancelOrder cancel = CancelOrder.builder()
				.orderId(orderId)
				.build();
		result = orderRepository.insertCancelOrder(cancel, 1, orderId);
		result = orderRepository.updateOrderStatus(orderNo, 5);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
		return result;
	}

	
	
	@Override
	public List<Order> getOrderListByPeriod(String memberId, int period, Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return orderRepository.getOrderListByPeriod(memberId, period, rowBounds);
	}
	
	

	@Override
	public OrderCancelInfoDto getCancelInfo(String orderNo) {
		return orderRepository.getCancelInfo(orderNo);
	}

	
	@Override
	public List<OrderCancelInfoDto> getCancelInfoAll(String memberId, Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return orderRepository.getCancelInfoAll(memberId, rowBounds);
	}
	

	
	@Override
	public List<OrderCancelInfoDto> getCancelInfoByPeriod(String memberId, int period, Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return orderRepository.getCancelInfoByPeriod(memberId, period, rowBounds);
	}
	

	@Override
	public int deleteOrder(String orderNo) {
		return orderRepository.deleteOrder(orderNo);
	}
	

	/**
	 * @author 김담희
	 * 주문 상세 내역 조회
	 * 주문 내역과 그에 매칭되는 결제 정보를 담아 반환
	 */
	@Override
	public List<Map<OrderHistoryDto, Payment>> getOrderDetail(String orderNo) {
		List<Map<OrderHistoryDto, Payment>> orderList = new ArrayList<>();
		
		Map<OrderHistoryDto, Payment> orderDetailMap = new HashMap<>();
		
		List<OrderHistoryDto> history = orderRepository.getOrderDetail(orderNo);
		Payment payment = paymentRepository.getPaymentInfo(history.get(0).getOrderId());
		
		for(OrderHistoryDto o : history) {
			orderDetailMap.put(o, payment);
		}
		
		orderList.add(orderDetailMap);
		
		return orderList;
	}
	
	
	

	@Override
	public Order findOrderByOrderNo(String orderNo) {
		return orderRepository.findOrderByOrderNo(orderNo);
	}

	@Override
	public boolean reviewWrite(String memberId, int orderId, int productDetailId, int productId) {
		return orderRepository.reviewWrite(memberId, orderId, productDetailId, productId);
	}

	
	// 상품별 주문확정 주문 수 조회 (수경)
	@Override
	public int findOrderCntByProductId(int productDetailId) {
		return orderRepository.findOrderCntByProductId(productDetailId);
	}

	// 리뷰 리스트 - 주문자 연결 (혜령)
	@Override
	public List<OrderReviewListDto> findOrdersByReviewId(String reviewMemberId) {
		return orderRepository.findOrdersByReviewId(reviewMemberId);
	}
	
	
	
	/**
	 * @author 김담희
	 * 결제하고 7일이 지났으며 주문 상태가 "배송완료"일 경우, 주문 상태를
	 * 주문 확정으로 변경
	 */
	@Override
	public int updateOrderStatusIfExpired() {
		int result = 0;
        List<Order> orders = orderRepository.findOrdersWithExpiredStatus();
        for (Order order : orders) {
            result = orderRepository.updateOrderStatus(order.getOrderNo(), 6);
        }
        return result;
	}
	

	// 상품상세 - 리뷰 - 상품
	@Override
	public List<OrderReviewListDto> findProductByReviewId(int reviewId, int productId) {
		return orderRepository.findProductByReviewId(reviewId, productId);
	}
	

	@Override
	public int findTotalOrderCount(String memberId) {
		return orderRepository.findTotalOrderCount(memberId);
	}


	@Override
	public int findTotalCancelOrderCount(String memberId) {
		return orderRepository.findTotalCacncelOrderCount(memberId);
	}

}
