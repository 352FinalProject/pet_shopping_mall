package com.shop.app.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.shop.app.common.HelloSpringUtils;
import com.shop.app.common.entity.imageAttachment;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;
import com.shop.app.review.dto.ReviewCreateDto;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;
import com.shop.app.review.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 혜령
 * - 리뷰
 */
@Controller
@Slf4j
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private PointService pointService;
	
	// 내가 쓴 리뷰 조회 페이지 불러오기 + 페이징바
	@GetMapping("/reviewList.do")
	public void reviewList(
			@RequestParam int reviewId,
			Model model) {
		
//		int limit = 10;
//		
//		Map<String, Object> params = Map.of(
//				"page", page,
//				"limit", limit
//			);
//		
//		int totalCount = reviewService.findTotalReviewCount();
//		int totalPages = (int) Math.ceil((double) totalCount / limit);
//		model.addAttribute("totalPages", totalPages);
		
//		List<Review> reviews = reviewService.findReviewAll(params);
//		model.addAttribute("reviews", reviews);
		
		Review review = Review
				.builder()
				.reviewId(reviewId)
				.build();
		
		Review reviews = reviewService.findReviewId(review);
		model.addAttribute("reviews", reviews);
		
	}
	
	// 리뷰 작성 페이지 불러오기
	@GetMapping("/reviewCreate.do")
	public void reviewCreate() {
	
	}
	
	   // 리뷰 작성
	   @PostMapping("/reviewCreate.do")
	   public String reviewCreate(
	         @Valid ReviewCreateDto _review, 
	         BindingResult bindingResult, 
	         @RequestParam(value = "upFile", required = false) List<MultipartFile> upFiles, Point point) 
	               throws IllegalStateException, IOException {
	   
	      // 1. 파일저장
	      List<imageAttachment> attachments = new ArrayList<>();
	      boolean hasImage = false; // 이미지 있는지 확인하는 변수 (예라)
	      
	      for(MultipartFile upFile : upFiles) {
	         if(!upFile.isEmpty()) {
	            String imageOriginalFilename = upFile.getOriginalFilename();
	            String imageRenamedFilename = HelloSpringUtils.getRenameFilename(imageOriginalFilename);
	            File destFile = new File(imageRenamedFilename);
	            upFile.transferTo(destFile);
	            
	            int imageType = 1;
	            
	            imageAttachment attach =
	                  imageAttachment.builder()
	                  .imageOriginalFilename(imageOriginalFilename)
	                  .imageRenamedFilename(imageRenamedFilename)
	                  .imageType(imageType)
	                  .imageFileSize(upFile.getSize())
	                  .build();
	                  
	            log.debug("review attach = {}", attach);
	            attachments.add(attach);
	            hasImage = true; // 이미지가 있으면 true (예라)
	         }
	      }
	      
	      // 2. db저장
	      ReviewDetails reviews = ReviewDetails.builder()
	            .reviewMemberId(_review.getReviewMemberId())
	            .reviewStarRate(_review.getReviewStarRate())
	            .reviewTitle(_review.getReviewTitle())
	            .reviewContent(_review.getReviewContent())
	            .attachments(attachments)
	            .build();
	      
	      int result = reviewService.insertReview(reviews);
	      
	      // 리뷰의 멤버 ID 값을 포인트 객체의 멤버 ID로 설정
	      point.setPointMemberId(_review.getReviewMemberId());
	      
	      // 3. memberId값으로 현재 사용자의 포인트 가져오기 (예라)
	      Point currentPoints = pointService.findReviewPointCurrentById(point); 
	      
	      log.debug("ReviewDetails reviewMemberId = {}", reviews.getReviewMemberId());
	      log.debug("currentPoints = {}", currentPoints);
	      
	      // 4. 리뷰 작성하면 현재 포인트에 추가로 포인트 적립 (텍스트 500원, 이미지 1000원)
	      int pointAmount = 500;
	      if (hasImage) {
	          pointAmount += 500;
	      }

	      // 5. 현재 포인트를 가져온 후 포인트 적립 계산
	      int updatedPointAmount = currentPoints.getPointCurrent() + pointAmount;

	      // 6. 포인트 테이블에 행 추가
	      Point newPoint = new Point();
	      newPoint.setPointCurrent(updatedPointAmount); 
	      newPoint.setPointAmount(pointAmount); 
	      newPoint.setPointType("리뷰적립");
	      newPoint.setPointMemberId(_review.getReviewMemberId());

	      int newPointResult = pointService.insertPoint(newPoint);
	      
	      return "redirect:/review/reviewCreate.do";
	   

	   }
	
}
