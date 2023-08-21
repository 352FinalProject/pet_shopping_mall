package com.shop.app.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.shop.app.common.HelloSpringUtils;
import com.shop.app.common.ImageService;
import com.shop.app.common.entity.imageAttachment;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;
import com.shop.app.review.dto.ReviewCreateDto;
import com.shop.app.review.dto.ReviewUpdateDto;
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

	//	@Autowired 
	//	private ImageService imageService; // 이미지 서비스 주입
	//	
	//	// 리뷰 페이지에서 이미지를 불러오는 컨트롤러 메소드
	//    @GetMapping("/reviews/{reviewId}/image/{filename:.+}")
	//    @ResponseBody
	//    public ResponseEntity<Resource> serveImage(@PathVariable Long reviewId, @PathVariable String filename) {
	//        Resource image = imageService.loadImage(reviewId, filename); // 이미지 서비스에서 이미지 로드
	//
	//        // 이미지 타입에 따라 Content-Type 설정
	//        String contentType = determineContentType(filename);
	//        return ResponseEntity.ok()
	//                .header(HttpHeaders.CONTENT_TYPE, contentType)
	//                .body(image);
	//    }
	//
	//    // 파일 확장자에 따라 Content-Type을 결정하는 메소드
	//    private String determineContentType(String filename) {
	//        String extension = FilenameUtils.getExtension(filename.toLowerCase());
	//        switch (extension) {
	//            case "jpg":
	//            case "jpeg":
	//                return "image/jpeg";
	//            case "png":
	//                return "image/png";
	//            // 추가적인 이미지 확장자 처리 가능
	//            default:
	//                return "application/octet-stream"; // 기본적으로 이진 데이터로 설정
	//        }
	//    }


	// 내가 쓴 리뷰 조회 페이지 불러오기 + 페이징바
	@GetMapping("/reviewList.do")
	public void reviewList(
			@RequestParam(defaultValue = "1") int page,
			Model model) {

		int limit = 5;

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String reviewMemberId = authentication.getName();

		Map<String, Object> params = Map.of(
				"page", page,
				"limit", limit,
				"reviewMemberId", reviewMemberId
				);

		int totalCount = reviewService.findTotalReviewCount(reviewMemberId);
		int totalPages = (int) Math.ceil((double) totalCount / limit);
		model.addAttribute("totalPages", totalPages);

		List<Review> reviews = reviewService.findReviewAll(params);

		log.debug("토탈카운트 = {} ", totalCount);
		log.debug("페이지, 리밋, 멤버아이디 params = {}", params);
		log.debug("파람스 들어가있는거 reviews = {}", reviews);

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
				.reviewId(_review.getReviewId())
				.reviewMemberId(_review.getReviewMemberId())
				.reviewStarRate(_review.getReviewStarRate())
				.reviewTitle(_review.getReviewTitle())
				.reviewContent(_review.getReviewContent())
				.attachments(attachments)
				.build();

		int reviewId = reviewService.insertReview(reviews);
		Review pointReviewId = reviewService.findReviewId(reviews);

		// 3. 리뷰의 멤버 ID 값을 포인트 객체의 멤버 ID로 설정
		point.setPointMemberId(_review.getReviewMemberId());
		point.setReviewId(_review.getReviewId());

		// 4. memberId값으로 현재 사용자의 포인트 가져오기 (예라)
		Point currentPoints = pointService.findReviewPointCurrentById(point); 

		// 5. 리뷰 작성하면 현재 포인트에 추가로 포인트 적립 (텍스트 500원, 이미지 1000원)
		int pointAmount = 500;
		if (hasImage) {
			pointAmount += 500;
		}

		// 6. 현재 포인트를 가져온 후 포인트 적립 계산
		int updatedPointAmount = currentPoints.getPointCurrent() + pointAmount;

		// 7. 포인트 테이블에 행 추가
		Point newPoint = new Point();
		newPoint.setPointCurrent(updatedPointAmount); 
		newPoint.setPointAmount(pointAmount); 
		newPoint.setPointType("리뷰적립");
		newPoint.setPointMemberId(_review.getReviewMemberId());
		newPoint.setReviewId(pointReviewId.getReviewId());
		
		log.debug("newPoint = {}", newPoint);

		int newPointResult = pointService.insertPoint(newPoint);

		return "redirect:/review/reviewList.do";
	}

	// 리뷰 삭제
	@PostMapping("/reviewDelete.do")
	public String reviewDelete(@RequestParam int reviewId) {

		// 1. 리뷰 id로 적립된 포인트 찾기
		Point earnedPoint = pointService.getPointByReviewId(reviewId);

		if (earnedPoint != null) {
			// 2. 현재 포인트에서 적립된 포인트 빼기
			Point currentPoints = pointService.findReviewPointCurrentById(earnedPoint); 
			int updatedPointAmount = currentPoints.getPointCurrent() - earnedPoint.getPointAmount();

			// 3. 포인트 테이블에 행 추가 또는 업데이트
			Point rollbackPoint = new Point();
			rollbackPoint.setPointCurrent(updatedPointAmount);
			rollbackPoint.setPointAmount(-earnedPoint.getPointAmount());
			rollbackPoint.setPointType("리뷰삭제");
			rollbackPoint.setPointMemberId(earnedPoint.getPointMemberId());
			rollbackPoint.setReviewId(reviewId);
			
			log.debug("rollbackPoint = {}", rollbackPoint);

			int rollbackResult = pointService.insertRollbackPoint(rollbackPoint);
		}

		// 리뷰 삭제
		int result = reviewService.reviewDelete(reviewId);

		return "redirect:/review/reviewList.do";
	}


	// 리뷰 상세조회 
	@GetMapping("/reviewDetail.do")
	public void reviewDetail(@RequestParam(required=true) int reviewId, Model model) {

		Review review = Review.builder()
				.reviewId(reviewId)
				.build();

		Review reviews = reviewService.findReviewId(review);
		model.addAttribute("reviews", reviews);

		// 이미지 파일 정보 조회
		ReviewDetails reviewDetails = reviewService.findImageAttachmentsByReviewId(reviewId);
		log.debug("reviewDetails = {}", reviewDetails);
		model.addAttribute("reviewDetails", reviewDetails);

	}


	// 리뷰 수정 페이지 이동
	@GetMapping("/reviewUpdate.do")
	public void reviewUpdate(@RequestParam int reviewId, Model model) {

		Review review = Review.builder()
				.reviewId(reviewId)
				.build();

		Review reviews = reviewService.findReviewId(review);
		model.addAttribute("reviews", reviews);

	}

	// 리뷰 수정
	@PostMapping("/reviewUpdate.do")
	public String updateReview(ReviewUpdateDto _review) {

		Review reviews = _review.toReview();
		int result = reviewService.updateReview(reviews);

		log.debug("리뷰수정 result = {}", result);

		return "redirect:/review/reviewDetail.do?reviewId=" + reviews.getReviewId();

	}


}
