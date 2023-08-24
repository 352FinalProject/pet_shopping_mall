package com.shop.app.review.dto;

import java.security.Timestamp;

import com.shop.app.pet.entity.Pet;

public class ProductReviewDto {
	private String name;
	
	private String productId;
	private String reviewTitle;
	private String reviewContent;
	private Timestamp reviewCreatedAt;
	
	private Pet pet;
	
	// 이미지
}
