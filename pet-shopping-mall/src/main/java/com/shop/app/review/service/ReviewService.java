package com.shop.app.review.service;

import java.util.List;
import java.util.Map;

import com.shop.app.review.dto.ReviewDetails;
import com.shop.app.review.entity.Review;

public interface ReviewService {

	// 리뷰 작성
	int insertReview(Review review);

	// 리뷰 전체 카운트
	int findTotalReviewCount();

	// 내가 쓴 리뷰 목록 조회
	List<Review> findReviewAll(Map<String, Object> params);

}
