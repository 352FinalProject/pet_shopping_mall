package com.shop.app.review.dto;

import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;

import com.shop.app.pet.entity.PetGender;
import com.shop.app.review.entity.Review;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewCreateDto {
	
	private int reviewId;
	private String reviewMemberId; // 작성자
	private int petId;
	private int ProductId;
	
	private int reviewStarRate; // 별점
	
	@NotBlank(message = "리뷰 제목을 입력해주세요.")
	private String reviewTitle; // 제목
	
	@NotBlank(message = "리뷰 내용을 작성해주세요.")
	private String reviewContent; // 내용
	
	public Review toReview() {
		return Review.builder()
				.reviewId(reviewId)
				.reviewMemberId(reviewMemberId)
				.petId(petId)
				.productId(ProductId)
				.reviewStarRate(reviewStarRate)
				.reviewTitle(reviewTitle)
				.reviewContent(reviewContent)
				.build();
	}

}
