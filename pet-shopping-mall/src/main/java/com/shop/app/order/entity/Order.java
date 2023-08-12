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
	private String orderNo; // 주문번호 (ex 230811001)
	private String memberId;
	private Date orderDate;
	private int orderState;
	private int paymentState; // 0-결제 미완료 / 1-결제완료
	private int totalPrice; // 상품 금액 + 배송비
	private int deliveryFee; // 배송비 (고정 3000원)
	private int discount; // 할인금액 (포인트 또는 쿠폰으로 발생한 차감액)
	private int amount; // 실 결제 금액
	
}
