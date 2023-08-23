package com.shop.app.review.dto;

import java.time.LocalDateTime;

import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.entity.PetGender;
import com.shop.app.product.entity.Product;
import com.shop.app.review.entity.Review;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewDetailDto {

	private int reviewId;
	private String reviewMemberId;
	private String reviewTitle;
	private String reviewContent;
	private int reviewStarRate;
	private LocalDateTime reviewCreatedAt;
	
	public Review toReview() {
		return Review.builder()
				.reviewId(reviewId)
				.reviewMemberId(reviewMemberId)
				.reviewTitle(reviewTitle)
				.reviewContent(reviewContent)
				.reviewStarRate(reviewStarRate)
				.reviewCreatedAt(reviewCreatedAt)
				.build();
	}
	
	private int petId;
	private String petName;
	private int petAge;
	private String petBreed;
	private String petWeight;
	private PetGender petGender;
	
	public Pet toPet() {
		return Pet.builder()
				.petId(petId)
				.petName(petName)
				.petAge(petAge)
				.petBreed(petBreed)
				.petWeight(petWeight)
				.petGender(petGender)
				.build();
	}
	
	private int productId;
	private String productName;
	
	public Product toProduct() {
		return Product.builder()
				.productId(productId)
				.productName(productName)
				.build();
	}
}
