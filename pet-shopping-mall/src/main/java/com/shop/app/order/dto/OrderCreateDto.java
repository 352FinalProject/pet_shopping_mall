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
		
	    int afterDiscount = pointsUsed;  // 사용한 포인트가 할인될 금액 (예라)
	    int finalAmount = amount - afterDiscount;  // 최종 결제 금액 (예라)
	    
		return Order.builder()
				.orderNo(orderNo)
				.memberId(memberId)
				.totalPrice(totalPrice)
				.deliveryFee(deliveryFee)
				.discount(afterDiscount)  // 사용된 포인트를 할인 금액으로 설정 (예라)
				.amount(finalAmount)        // 할인된 금액을 반영하여 결제 금액 설정 (예라)
				.build();
	}

}
