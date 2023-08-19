package com.shop.app.review.dto;

import com.shop.app.review.entity.Review;

public class ReviewUpdateDto {

	private int reviewId;
	
	private String reviewTitle;
	private String reviewContent;
	
	private int reviewStarRate; // 별점
	
	public Review toReview() {
		return Review.builder()
				.reviewId(reviewId)
				.reviewTitle(reviewTitle)
				.reviewContent(reviewContent)
				.reviewStarRate(reviewStarRate)
				.build();
		
	}
	
}
