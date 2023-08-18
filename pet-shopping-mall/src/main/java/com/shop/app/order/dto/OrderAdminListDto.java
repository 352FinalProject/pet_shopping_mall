package com.shop.app.order.dto;

import java.sql.Date;

import javax.validation.Valid;

import com.shop.app.order.entity.Order;

import lombok.Data;

public class OrderAdminListDto {
	private int orderId;
	private Date orderDate; // 주문 일시 (orderTbl)
	private String orderNo; // 주문 번호 (orderTbl)
	private String productName; // 주문 상품 (product)
	private int orderStatus;// 주문 상태 (orderTbl)
	private int paymentState;// 결제 상태 (orderTbl)
	private String memberName;// 주문자(이름) (member)
	private int amount; // 실 결제금액	(orderTbl)
	private int deliveryFee; // 배송비 (orderTbl)
	private int paymentMethod;// 결제방법 (payment)
}
