package com.shop.app.order.entity;

import java.sql.Timestamp;

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
	private Timestamp orderDate; // 주문날짜
	
	private int orderStatus; 
	
	private int paymentState; // 0: 결제 미완료 / 1: 결제완료
	
	private int totalPrice; // 순수 상품의 가격
	private int deliveryFee; // 배송비 (고정 3000원)
	private int discount; // 할인금액 (포인트 또는 쿠폰으로 발생한 차감액)
	private String discountDetail; // true면 쿠폰, false면 포인트
	private int amount; // 실 결제 금액
	
	private Integer memberCouponId; // 멤버 쿠폰 아이디
	
}
