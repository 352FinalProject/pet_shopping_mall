package com.shop.app.review.dto;

import lombok.Data;

@Data
public class ReviewProductDto {

	private int reviewId;
	
	private String productName; // product
	private String optionName; // product_detail
	private String optionValue; // product_detail
	
}
