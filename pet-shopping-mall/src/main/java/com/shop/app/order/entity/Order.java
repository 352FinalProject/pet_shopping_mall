package com.shop.app.order.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Order {
	private int orderId; // 시퀀스
	private String orderNo; // 주문번호 (ex 230811-001)
	private String memberId;
	private Date orderDate; // 주문날짜
	
	// 주문 상태
	// 0: 결제대기 / 1: 결제완료 / 2: 배송준비 / 3: 배송중 / 4: 배송완료 / 5: 주문취소 / 6: 환불 / 7: 구매확정
	private int orderStatus; 
	
	private int paymentState; // 0: 결제 미완료 / 1: 결제완료
	
	private int totalPrice; // 순수 상품의 가격
	private int deliveryFee; // 배송비 (고정 3000원)
	private int discount; // 할인금액 (포인트 또는 쿠폰으로 발생한 차감액)
	private int amount; // 실 결제 금액
	
	private int memberCouponId; // 쿠폰 기능 할 수도 있으니까 만들어놓은 컬럼, null 처리해도 됨
	
}
