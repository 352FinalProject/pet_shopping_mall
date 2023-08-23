package com.shop.app.review.service;

import java.util.List;
import java.util.Map;

import com.shop.app.review.dto.ReviewDetailDto;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;

public interface ReviewService {

	// 리뷰 작성
	int insertReview(Review review);

	// 리뷰 삭제
	int reviewDelete(int reviewId);

	// 내가 쓴 리뷰 목록 조회
	List<Review> findReviewAll(Map<String, Object> params);
	//	List<Review> findReviewAll(int reviewId);
	
	// 리뷰 상세조회
	ReviewDetailDto findReviewId(int reviewId);

	// 리뷰 상세 - 이미지 조회
	ReviewDetails findImageAttachmentsByReviewId(int reviewId);

	// 리뷰 수정
	int updateReview(Review review);

	// 리뷰 전체 카운트
	int findTotalReviewCount(String reviewMemberId);
	
	// 삭제되는 리뷰 정보 가져오기 (예라)
	ReviewDetails getDeleteReviewById(int reviewId);

	// 상품 상세페이지 리뷰 전체 카운트
	int findProductTotalReviewCount();

	// 상품 상세페이지 전체 리뷰 
	List<Review> findProductReviewAll(Map<String, Object> params);

	// 상품 상세페이지 - 리뷰 상세조회 - 이미지 조회
	ReviewDetails findProductImageAttachmentsByReviewId(int reviewId);

}
