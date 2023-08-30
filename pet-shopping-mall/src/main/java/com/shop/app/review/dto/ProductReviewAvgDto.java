package com.shop.app.review.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductReviewAvgDto {
	
	private String productName; // product
	private int productId; // product
	private double reviewStarRate; // review
}
