package com.shop.app.review.dto;

import java.sql.Date;

import com.shop.app.order.dto.OrderAdminListDto;
import com.shop.app.product.entity.Product;
import com.shop.app.review.entity.Review;

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
	
	private int reviewStarRate; // review
	private int AVG;
}
