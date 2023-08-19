package com.shop.app.review.service;

import java.util.List;
import java.util.Map;

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
	Review findReviewId(Review review);

	// 리뷰 상세 - 이미지 조회
	ReviewDetails findImageAttachmentsByReviewId(int reviewId);

	// 리뷰 수정
	int updateReview(Review review);


}
