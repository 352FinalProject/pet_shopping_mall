package com.shop.app.order.dto;

import java.sql.Timestamp;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class OrderHistoryDto {
	private int orderId;
	private Timestamp orderDate;
	private String orderNo; 
	private String productName; 
	private String optionName; 
	private String optionValue; 
	private String quantity; 
	private int amount; 
	private int productDetailId; 
	private int orderStatus;
	private int productId;
	private String thumbnail;
}
