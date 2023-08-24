package com.shop.app.order.dto;

import java.sql.Timestamp;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class OrderHistoryDto {
	private int orderId;
	private Timestamp orderDate; // orderTbl
	private String orderNo; // orderTbl
	private String productName; // product
	private String optionName; // product_detail
	private String optionValue; // product_detail
	private String quantity; // order_detail
	private int amount; // orderTbl
	
	// 0: 입금대기 / 1: 입금완료 / 2: 배송준비 / 3: 배송중 / 4: 배송완료 / 5: 주문취소 / 6: 환불 / 7:반품
	private int orderStatus;
	
}
