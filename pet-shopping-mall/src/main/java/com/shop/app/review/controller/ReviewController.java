package com.shop.app.review.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.common.HelloSpringUtils;
import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.common.entity.Thumbnail;
import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.dto.OrderReviewListDto;
import com.shop.app.order.entity.Order;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.notification.entity.Notification;
import com.shop.app.notification.repository.NotificationRepository;
import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.service.OrderService;
import com.shop.app.payment.entity.Payment;
import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.service.PetService;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.service.ProductService;
import com.shop.app.review.dto.ReviewCreateDto;
import com.shop.app.review.dto.ReviewDetailDto;
import com.shop.app.review.dto.ReviewListDto;
import com.shop.app.review.dto.ReviewProductDto;
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
	
	@Autowired
	private PetService petService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ServletContext application;

	@Autowired
	NotificationRepository notificationRepository;
	
	@Autowired
	SimpMessagingTemplate simpMessagingTemplate;

	
	/**
	 * @author 혜령
	 * - 내가 쓴 리뷰 조회 페이지 불러오기 + 페이징바
	 */
	@GetMapping("/reviewList.do")
	public void reviewList(
			@RequestParam(defaultValue = "1") int page,
			@AuthenticationPrincipal MemberDetails member,
			Model model
			) {

		int limit = 5;

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String reviewMemberId = authentication.getName();
		
		// 리뷰 작성자가 주문한 상품 내역들
		List<OrderReviewListDto> orders = orderService.findOrdersByReviewId(reviewMemberId);

		Map<String, Object> params = Map.of(
				"page", page,
				"limit", limit,
				"reviewMemberId", reviewMemberId,
				"orders", orders
				);
		
		int totalCount = reviewService.findTotalReviewCount(reviewMemberId);
		int totalPages = (int) Math.ceil((double) totalCount / limit);
		model.addAttribute("totalPages", totalPages);

		// 리뷰에 보여줄 내용들
		List<ReviewListDto> reviews = reviewService.findReviewAll(params);
		
		model.addAttribute("reviews", reviews);
	}

	/**
	 * @author 혜령
	 * - 리뷰 작성 페이지 불러오기
	 */
	@GetMapping("/reviewCreate.do")
	public void reviewCreate(
			@RequestParam("productDetailId") int productDetailId, 
			@RequestParam("productId") int productId, 
			@RequestParam("orderId") int orderId, 
			Model model) {
		
		model.addAttribute("productDetailId", productDetailId);
		model.addAttribute("productId", productId);
		model.addAttribute("orderId", orderId);
	   
	}

	/**
	 * @author 이혜령
	 * 리뷰 작성
	 * 
	 * @author 전예라
	 * 리뷰 작성 시 텍스트 500원, 사진 1000원 포인트 적립
	 * 
	 * @author 김대원
	 * 리뷰 작성 시 회원에게 포인트 적립 알림
	 */
	@PostMapping("/reviewCreate.do")
	public String reviewCreate(
			@ModelAttribute
			@Valid ReviewCreateDto _review, 
			BindingResult bindingResult, 
			@RequestParam(value = "upFile", required = false) List<MultipartFile> upFiles, 
			Point point, 
			Pet pet,
			Principal principal, Model model)
					throws IllegalStateException, IOException {

		// 1. 파일저장
		List<ImageAttachment> attachments = new ArrayList<>();
		boolean hasImage = false;

		// 이미지 상대경로 지정
		String saveDirectory = application.getRealPath("/resources/upload/review");
		
		for(MultipartFile upFile : upFiles) {
			if(!upFile.isEmpty()) {
				String imageOriginalFilename = upFile.getOriginalFilename();
				String imageRenamedFilename = HelloSpringUtils.getRenameFilename(imageOriginalFilename);
				File destFile = new File(saveDirectory, imageRenamedFilename);
				
				upFile.transferTo(destFile);

				int imageType = 1;
				Thumbnail thumbnail = Thumbnail.N;

				ImageAttachment attach =
						ImageAttachment.builder()
						.imageOriginalFilename(imageOriginalFilename)
						.imageRenamedFilename(imageRenamedFilename)
						.imageType(imageType)
						.thumbnail(thumbnail)
						.imageFileSize(upFile.getSize())
						.build();
				attachments.add(attach);
				hasImage = true;
			}
		}
		
		// 2. db저장
		ReviewDetails reviews = ReviewDetails.builder()
				.reviewId(_review.getReviewId())
				.petId(pet.getPetId())
				.orderId(_review.getOrderId())
				.productId(_review.getProductId())
				.productDetailId(_review.getProductDetailId())
				.reviewMemberId(_review.getReviewMemberId())
				.reviewStarRate(_review.getReviewStarRate())
				.reviewTitle(_review.getReviewTitle())
				.reviewContent(_review.getReviewContent())
				.attachments(attachments)
				.build();
		
		// petId 연결하기
		// petId 로그인 멤버 말고 리뷰작성자랑 연결하기
		String memberId = _review.getReviewMemberId();
		List<Pet> petInfo = petService.findPetsByMemberId(memberId); // 리뷰작성자의 펫정보 가져오기
		
		if (!petInfo.isEmpty()) { // 펫정보가 비어있지 않다면
			Pet firstPet = petInfo.get(0); // 첫번째 Pet 객체 가져오기
			reviews.setPetId(firstPet.getPetId()); // db에 pet정보 저장
		} else {
			reviews.setPetId(null);
		}
			
	
		int reviewId = reviewService.insertReview(reviews);
		int orderId = reviews.getOrderId();
		int productDetailId = reviews.getProductDetailId();
		String reviewMemberId = reviews.getReviewMemberId();
		
		ReviewDetailDto pointReviewId = reviewService.findReviewId(reviews.getReviewId());

		point.setPointMemberId(_review.getReviewMemberId());
		point.setReviewId(_review.getReviewId());

		Point currentPoints = pointService.findReviewPointCurrentById(point); 

		int pointAmount = 500;
		if (hasImage) {
			pointAmount += 500;
		}

		int updatedPointAmount = currentPoints.getPointCurrent() + pointAmount;

		Point newPoint = new Point();
		newPoint.setPointCurrent(updatedPointAmount); 
		newPoint.setPointAmount(pointAmount); 
		newPoint.setPointType("리뷰적립");
		newPoint.setPointMemberId(_review.getReviewMemberId());
		newPoint.setReviewId(pointReviewId.getReviewId());

		int newPointResult = pointService.insertPoint(newPoint);
		
		String to = newPoint.getPointMemberId();
		Notification insertNotification = Notification.builder()
				.notiCategory(3)
				.notiContent("리뷰 작성 포인트가 적립되었습니다.")
				.notiCreatedAt(formatTimestampNow())
				.memberId(to) 
				.build();
		
		notificationRepository.insertNotification(insertNotification);
		Notification notification = notificationRepository.latestNotification();
		simpMessagingTemplate.convertAndSend("/pet/notice/" + to, notification);

		return "redirect:/review/reviewList.do";
	}

	/**
	 * @author 이혜령
	 * 리뷰 삭제
	 * 
	 * @author 전예라
	 * 리뷰 삭제 시 적립된 포인트 반환
	 */
	@PostMapping("/reviewDelete.do")
	public String reviewDelete(@RequestParam int reviewId) {

		Point earnedPoint = pointService.getPointByReviewId(reviewId);

		if (earnedPoint != null) {
			Point currentPoints = pointService.findReviewPointCurrentById(earnedPoint); 
			int updatedPointAmount = currentPoints.getPointCurrent() - earnedPoint.getPointAmount();

			Point rollbackPoint = new Point();
			rollbackPoint.setPointCurrent(updatedPointAmount);
			rollbackPoint.setPointAmount(-earnedPoint.getPointAmount());
			rollbackPoint.setPointType("리뷰삭제");
			rollbackPoint.setPointMemberId(earnedPoint.getPointMemberId());
			rollbackPoint.setReviewId(reviewId);

			int rollbackResult = pointService.insertRollbackPoint(rollbackPoint);
		}

		// 리뷰 삭제
		int result = reviewService.reviewDelete(reviewId);

		return "redirect:/review/reviewList.do";
	}


	/**
	 * @author 이혜령
	 * 리뷰 상세조회
	 */
	@GetMapping("/reviewDetail.do")
	public void reviewDetail(
			@RequestParam(required=true) int reviewId, 
			Model model, 
			Pet pet, 
			Principal principal) {
		
		ReviewDetailDto reviews = reviewService.findReviewId(reviewId);
		model.addAttribute("reviews", reviews);
		
		// 이미지 파일 정보 조회
		ReviewDetails reviewDetails = reviewService.findImageAttachmentsByReviewId(reviewId);
		model.addAttribute("reviewDetails", reviewDetails);
		
		// 구매한 상품 정보 조회
		ReviewProductDto reviewProduct = reviewService.findProductReviewId(reviewId);
		model.addAttribute("reviewProduct", reviewProduct);
		
	}


	/**
	 * @author 이혜령
	 *  리뷰 수정 페이지 이동
	 */
	@GetMapping("/reviewUpdate.do")
	public void reviewUpdate(@RequestParam int reviewId, Model model) {

		ReviewDetailDto reviews = reviewService.findReviewId(reviewId);
		model.addAttribute("reviews", reviews);

	}

	/**
	 * @author 이혜령
	 *  리뷰 수정
	 */
	@PostMapping("/reviewUpdate.do")
	public String updateReview(ReviewUpdateDto _review) {

		Review reviews = _review.toReview();
		int result = reviewService.updateReview(reviews);
		
		return "redirect:/review/reviewDetail.do?reviewId=" + reviews.getReviewId();

	}

	private String formatTimestamp(Timestamp timestamp) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yy/MM/dd HH:mm:ss");
        return dateFormat.format(timestamp);
	}
	private String formatTimestampNow() {
	    return formatTimestamp(new Timestamp(System.currentTimeMillis()));
	}

}