package com.shop.app.review.service;

import java.util.List;
import java.util.Map;

import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.review.dto.ProductReviewAvgDto;
import com.shop.app.review.dto.ReviewDetailDto;
import com.shop.app.review.dto.ReviewListDto;
import com.shop.app.review.dto.ReviewProductDto;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;

public interface ReviewService {

	// 리뷰 작성
	int insertReview(Review review);

	// 리뷰 삭제
	int reviewDelete(int reviewId);

	// 내가 쓴 리뷰 목록 조회
	List<ReviewListDto> findReviewAll(Map<String, Object> params);
	//	List<Review> findReviewAll(int reviewId);
	
	// 리뷰 상세조회
	ReviewDetailDto findReviewId(int reviewId);

	// 리뷰 상세 - 이미지 조회
	ReviewDetails findImageAttachmentsByReviewId(int reviewId);

	// 리뷰 상세 - 구매한 상품내역 조회
	ReviewProductDto findProductReviewId(int reviewId);

	// 리뷰 수정
	int updateReview(Review review);

	// 리뷰 전체 카운트
	int findTotalReviewCount(String reviewMemberId);
	
	ReviewDetails getDeleteReviewById(int reviewId);

	// 상품 상세페이지 리뷰 전체 카운트
	int findProductTotalReviewCount(int productId);

	// 상품 상세페이지 전체 리뷰 
	List<Review> findProductReviewAll(Map<String, Object> params, int productId);

	// 상품 상세페이지 - 리뷰 상세조회 - 이미지 조회
	ReviewDetails findProductImageAttachmentsByReviewId(int reviewId);

	// 상품 상세페이지 이미지 조회
	ReviewDetails findImageAttachmentsByReviewMemberId(int reviewId);

	String findImageFilenameByReviewId(int reviewId2);

	Review findPoductListReviewId(int reviewId);

	// 상품 - 리뷰 전체개수 확인
	int findReviewTotalCount(int productId);

//	Review productReviewStarAvg(int productId);

//	List<ProductReviewAvgDto> findProductReviewAvgAll(int productId);

	// 상품 - 리뷰 평균 별점
	ProductReviewAvgDto productReviewStarAvg(int productId);

	// 상품 상세 페이지 - 리뷰 전체개수 확인
	int findProductListReviewTotalCount(int productId);
   
	// 별점 퍼센트 구하기 위한 전체 리뷰
	List<Review> findProductReviewAllNoPageBar(int productId);

	ReviewDetails findProductImageAttachmentsByReviewId2(int reviewId2, int orderId);
//	ReviewDetails findProductImageAttachmentsByReviewId2(int reviewId2);





//	List<ReviewDetailDto> findProductReviewDetails(List<Review> reviews);


}