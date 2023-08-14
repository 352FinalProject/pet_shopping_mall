package com.shop.app.review.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.common.entity.Attachment;
import com.shop.app.review.dto.ReviewDetails;
import com.shop.app.review.entity.Review;
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
		
		// attachment 저장
		List<Attachment> attachments = ((ReviewDetails) review).getAttachments();
		if(attachments != null && !attachments.isEmpty()) {
			for(Attachment attach : attachments) {
				attach.setImageId(review.getReviewId());
				result = reviewRepository.insertAttachment(attach);
			}
		}
		return result;
	}

	@Override
	public int findTotalReviewCount() {
		return reviewRepository.findTotalReviewCount();
	}

	@Override
	public List<Review> findReviewAll(Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return reviewRepository.findReviewAll(rowBounds);
	}

}
