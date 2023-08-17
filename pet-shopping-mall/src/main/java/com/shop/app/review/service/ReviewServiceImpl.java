package com.shop.app.review.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.common.entity.imageAttachment;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;
import com.shop.app.review.repository.ReviewRepository;

import lombok.extern.slf4j.Slf4j;


@Transactional(rollbackFor = Exception.class) // service 단에 쓰는거임. 
@Service
@Slf4j
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewRepository reviewRepository;
	
	@Override
	public int insertReview(Review review) {
		int result = 0;
		
		// review 저장
		result = reviewRepository.insertReview(review);
		
		log.debug("reviews = {}", review);
		
		
		int refId = review.getReviewId();
		System.out.println("review refId = " + refId);
		
		// attachment 저장
		List<imageAttachment> attachments = ((ReviewDetails) review).getAttachments();
		if(attachments != null && !attachments.isEmpty()) {
			for(imageAttachment attach : attachments) {
				
				int result2 = reviewRepository.insertAttachment(attach);
				
				int imageId = attach.getImageId();
				
				int reviewIdImageId = reviewRepository.insertMapping(refId, imageId);
				
			}
		}
		return result;
	}

//	@Override
//	public Review findReviewMemberById(Review review) {
//		return reviewRepository.findReviewMemberById(review);
//	}

	// 리뷰 삭제
	@Override
	public int reviewDelete(int reviewId) {
		return reviewRepository.reviewDelete(reviewId);
	}

//	@Override
//	public int findTotalReviewCount() {
//		return reviewRepository.findTotalReviewCount();
//	}

//	@Override
//	public List<Review> findReviewAll(Map<String, Object> params) {
//		int limit = (int) params.get("limit");
//		int page = (int) params.get("page");
//		int offset = (page - 1) * limit;
//		RowBounds rowBounds = new RowBounds(offset, limit);
//		return reviewRepository.findReviewAll(rowBounds);
//	}

	@Override
	public Review findReviewId(Review review) {
		return reviewRepository.findReviewId(review);
	}

}
