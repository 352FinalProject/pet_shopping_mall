package com.shop.app.review.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.common.entity.imageAttachment;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;
import com.shop.app.review.repository.ReviewRepository;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewRepository reviewRepository;
	
	// 리뷰추가
	@Override
	public int insertReview(Review review) {
		int result = 0;
		// review 저장
		result = reviewRepository.insertReview(review);
		
		int refId = review.getReviewId();
		System.out.println("review = " + review);
		System.out.println("review refId = " + refId);
		
		// attachment 저장
		List<imageAttachment> attachments = ((ReviewDetails) review).getAttachments();
		if(attachments != null && !attachments.isEmpty()) {
			for(imageAttachment attach : attachments) {
				
				// 1. 이미지 파일 DB에 저장
				int result2 = reviewRepository.insertAttachment(attach);
				
				// 2. 이미지 파일 DB 저장 후 생성된 이미지 ID 가져오기
				int imageId = attach.getImageId();
				
				// 3. 리뷰 ID와 이미지 ID를 사용하여 매핑 정보를 DB에 저장
				int reviewIdImageId = reviewRepository.insertMapping(refId, imageId);
			}
		}
		return result;
	}

	// 리뷰 삭제
	@Override
	public int reviewDelete(int reviewId) {
		return reviewRepository.reviewDelete(reviewId);
	}

	// 내가 쓴 리뷰목록 조회
	@Override
	public List<Review> findReviewAll(Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		String reviewMemberId = (String) params.get("reviewMemberId");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return reviewRepository.findReviewAll(reviewMemberId, rowBounds);
	}

	// 리뷰 전체 카운트
	@Override
	public int findTotalReviewCount(String reviewMemberId) {
		return reviewRepository.findTotalReviewCount(reviewMemberId);
	}

	// 리뷰 상세조회
	@Override
	public Review findReviewId(Review review) {
		return reviewRepository.findReviewId(review);
	}

	// 리뷰 상세조회 - 이미지 조회
	@Override
	public ReviewDetails findImageAttachmentsByReviewId(int reviewId) {
		return reviewRepository.findImageAttachmentsByReviewId(reviewId);
	}

	// 리뷰 수정
	@Override
	public int updateReview(Review review) {
		return reviewRepository.updateReview(review);
	}

	// 삭제되는 리뷰 정보 가져오기 (예라)
	@Override
	public ReviewDetails getDeleteReviewById(int reviewId) {
		return reviewRepository.getDeleteReviewById(reviewId);
	}
	
	
	// 상품 상세페이지 리뷰 전체 카운트
	@Override
	public int findProductTotalReviewCount() {
		return reviewRepository.findProductTotalReviewCount();
	}

	// 상품 상세페이지 전체 리뷰 
	@Override
	public List<Review> findProductReviewAll(Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return reviewRepository.findProductReviewAll(rowBounds);
	}

	// 상품 상세페이지 - 리뷰 상세조회 - 이미지 조회
	@Override
	public ReviewDetails findProductImageAttachmentsByReviewId(int reviewId) {
		return reviewRepository.findProductImageAttachmentsByReviewId(reviewId);
	}


}
