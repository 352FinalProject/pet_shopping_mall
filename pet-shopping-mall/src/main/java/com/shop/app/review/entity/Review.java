package com.shop.app.review.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Review {

	private int reviewId;
	private int petId;
	private int orderId;
	private String reviewTitle;
	private String reviewContent;
	private int reviewStarRate;
	private Date reviewCreatedAt;
	
	
}
