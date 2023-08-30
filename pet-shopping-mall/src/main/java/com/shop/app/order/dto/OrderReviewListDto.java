package com.shop.app.order.dto;

import lombok.Data;

@Data
public class OrderReviewListDto {

	private int orderId;
	
	private String productName; // product
	private String optionName; // product_detail
	private String optionValue; // product_detail
	
	private int productId;
	private int productDetailId;

	private String imageOriginalFileName;
	private String imageRenamedFileName;
	
	
}
