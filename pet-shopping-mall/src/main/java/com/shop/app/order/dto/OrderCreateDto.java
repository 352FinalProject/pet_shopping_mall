package com.shop.app.order.dto;


import javax.validation.Valid;

import com.shop.app.order.entity.Order;

import lombok.Data;

@Valid
@Data
public class OrderCreateDto {
	private String orderNo; // 주문번호 (ex 230811001)
	private String memberId;
	private int totalPrice;
	private int deliveryFee;
	private int discount;
	private int amount;
	private String discountCode;
	
	private int pointsUsed; // 사용하려는 포인트 (예라)
	
	public Order toOder() {
		return Order.builder()
				.orderNo(orderNo)
				.memberId(memberId)
				.totalPrice(totalPrice)
				.deliveryFee(deliveryFee)
				.discount(discount)
				.amount(amount)
				.build();
	}

}
