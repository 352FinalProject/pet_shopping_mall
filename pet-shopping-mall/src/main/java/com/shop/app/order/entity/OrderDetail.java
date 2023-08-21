package com.shop.app.order.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderDetail {
	private int orderId; // 참조하고 있는 주문 테이블 번호
	private int productDetailId; // 상세 제품 아이디 참조
	private int quantity; // 수량
}