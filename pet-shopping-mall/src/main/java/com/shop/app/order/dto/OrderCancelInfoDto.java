package com.shop.app.order.dto;

import lombok.Data;

@Data
public class OrderCancelInfoDto {
	private String name; //member
	private String phone; // member
	
	// 배송지
//	private String deliveryName;
//	private String deliveryPhone;
//	private String deliveryAddress;
	
	private String orderNo; // orderTbl
	private String orderDate; // orderTbl
	private int orderStatus;
	private int totalPrice;
	private String paymentMethod; // payment
	private int paymentStatus;
	
	private String paymentDate; // payment
	
	private int amount; // 총 금액 orderTbl
	private int discount; // 할인금액 orderTbl
}
