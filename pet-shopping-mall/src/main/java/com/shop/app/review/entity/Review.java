package com.shop.app.review.entity;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;


@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class Review {

	private int reviewId;
	private int petId;
	private int orderId;
	private String reviewTitle;
	private String reviewContent;
	private int reviewStarRate;
	private Date reviewCreatedAt;
	
	
	
	
}
