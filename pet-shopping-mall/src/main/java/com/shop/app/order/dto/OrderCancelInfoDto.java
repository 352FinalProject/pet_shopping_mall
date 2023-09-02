package com.shop.app.order.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderCancelInfoDto {
	private String name; //member
	private String phone; // member
	
	private String orderNo; // orderTbl
	private Timestamp orderDate; // orderTbl
	private int orderStatus;
	private int totalPrice;
	private String paymentMethod; // payment
	private int paymentStatus;
	private String address;
	
	private Timestamp paymentDate; // payment
	
	private int amount; // 총 금액 orderTbl
	private int discount; // 할인금액 orderTbl
}
