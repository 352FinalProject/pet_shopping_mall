package com.shop.app.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.shop.app.common.HelloSpringUtils;
import com.shop.app.common.entity.imageAttachment;
import com.shop.app.review.dto.ReviewCreateDto;
import com.shop.app.review.dto.ReviewDetails;
import com.shop.app.review.entity.Review;
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
	
	// 내가 쓴 리뷰 조회 페이지 불러오기 + 페이징바
	@GetMapping("/reviewList.do")
	public void reviewList(
			@RequestParam(defaultValue = "1") int page,
			Review review,
			Model model) {
		
		int limit = 10;
		
		Map<String, Object> params = Map.of(
				"page", page,
				"limit", limit
			);
		
		int totalCount = reviewService.findTotalReviewCount();
		int totalPages = (int) Math.ceil((double) totalCount / limit);
		model.addAttribute("totalPages", totalPages);
		
		List<Review> reviews = reviewService.findReviewAll(params);
		model.addAttribute("reviews", reviews);
		
	}
	
	// 리뷰 작성 페이지 불러오기
	@GetMapping("reviewCreate.do")
	public void reviewCreate() {}

	// 리뷰 작성
	@PostMapping("/reviewCreate.do")
	public String reviewCreate(
			@Valid ReviewCreateDto _review, 
			BindingResult bindingResult, 
			@RequestParam(value = "upFile", required = false) List<MultipartFile> upFiles) 
					throws IllegalStateException, IOException {
						
		// 1. 파일저장
		List<imageAttachment> attachments = new ArrayList<>();
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
			}
		}
		
		// 2. db저장
		ReviewDetails reviews = ReviewDetails.builder()
				.reviewStarRate(_review.getReviewStarRate())
				.reviewTitle(_review.getReviewTitle())
				.reviewContent(_review.getReviewContent())
				.attachments(attachments)
				.build();
		
		int result = reviewService.insertReview(reviews);
		
		return "redirect:/review/reviewCreate.do";
	}
		
	

		
	
	
}
