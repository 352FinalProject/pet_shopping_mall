package com.shop.app.review.dto;

import javax.validation.constraints.NotBlank;

import com.shop.app.review.entity.Review;

import lombok.Data;

@Data
public class ReviewCreateDto {
	
	// 작성자
	private String reviewMemberId;
	
	private int reviewStarRate; // 별점
	
	@NotBlank(message = "리뷰 제목을 입력해주세요.")
	private String reviewTitle; // 제목
	
	@NotBlank(message = "리뷰 내용을 작성해주세요.")
	private String reviewContent; // 내용
	
	public Review toReview() {
		return Review.builder()
				.reviewMemberId(reviewMemberId)
				.reviewStarRate(reviewStarRate)
				.reviewTitle(reviewTitle)
				.reviewContent(reviewContent)
				.build();
	}

}
