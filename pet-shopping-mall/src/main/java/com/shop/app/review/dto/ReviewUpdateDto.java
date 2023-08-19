package com.shop.app.review.dto;

import javax.validation.constraints.NotBlank;

import com.shop.app.review.entity.Review;

import lombok.Data;

@Data
public class ReviewUpdateDto {

	private int reviewId;
	
	@NotBlank(message = "리뷰 제목은 필수입니다.")
	private String reviewTitle;
	
	@NotBlank(message = "리뷰 내용은 필수입니다.")
	private String reviewContent;
	
	@NotBlank(message = "리뷰 별점은 필수입니다.")
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
