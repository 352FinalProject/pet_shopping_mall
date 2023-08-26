package com.shop.app.review.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
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
import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.entity.Order;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.service.OrderService;
import com.shop.app.payment.entity.Payment;
import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.service.PetService;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;
import com.shop.app.product.entity.Product;
import com.shop.app.product.service.ProductService;
import com.shop.app.review.dto.ReviewCreateDto;
import com.shop.app.review.dto.ReviewDetailDto;
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

	// 내가 쓴 리뷰 조회 페이지 불러오기 + 페이징바
	@GetMapping("/reviewList.do")
	public void reviewList(
			@RequestParam(defaultValue = "1") int page,
			@AuthenticationPrincipal MemberDetails member,
			Model model
//			@RequestParam String orderNo
			) {

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
		model.addAttribute("reviews", reviews);
		log.debug("reviews = {}", reviews);
		
		// 구매한 상품과 연결
		String memberId = member.getMemberId();
		List<Order> orderList;
		orderList = orderService.getOrderList(memberId);
		model.addAttribute("orderHistories", orderList);
		
		log.debug("orderList = {} ", orderList);
		
		// 구매한 상품 - 주문상세내역
		List<Map<OrderHistoryDto, Payment>> orderDetailMap = new ArrayList<>(); // 초기화

		for (Order order : orderList) {
		    String orderNo = order.getOrderNo(); // 각 주문의 orderNo 가져오기
		    List<Map<OrderHistoryDto, Payment>> orderDetail = orderService.getOrderDetail(orderNo);
		    orderDetailMap.addAll(orderDetail); // 주문상세내역을 orderDetailMap에 추가
		}

		model.addAttribute("orderDetailMap", orderDetailMap);

		log.debug("주문 상세내역 orderDetailMap = {}", orderDetailMap);
	
	}


	// 리뷰 작성 페이지 불러오기
	@GetMapping("/reviewCreate.do")
	public void reviewCreate(@RequestParam("productId") int productId, Model model) {
		model.addAttribute("productId", productId);
	   
	}

	// 리뷰 작성
	@PostMapping("/reviewCreate.do")
	public String reviewCreate(@ModelAttribute
			@Valid ReviewCreateDto _review, 
			BindingResult bindingResult, 
			@RequestParam(value = "upFile", required = false) List<MultipartFile> upFiles, 
			Point point, 
			Pet pet,
			Principal principal, Model model)
					throws IllegalStateException, IOException {

		// 1. 파일저장
		List<ImageAttachment> attachments = new ArrayList<>();
		boolean hasImage = false; // 이미지 있는지 확인하는 변수 (예라)

		// 이미지 상대경로 지정
		String saveDirectory = application.getRealPath("/resources/upload/review");
		
		for(MultipartFile upFile : upFiles) {
			if(!upFile.isEmpty()) {
				String imageOriginalFilename = upFile.getOriginalFilename();
				String imageRenamedFilename = HelloSpringUtils.getRenameFilename(imageOriginalFilename);
//				File destFile = new File(imageRenamedFilename);
				File destFile = new File(saveDirectory, imageRenamedFilename);
				
				upFile.transferTo(destFile);

				int imageType = 1;

				ImageAttachment attach =
						ImageAttachment.builder()
						.imageOriginalFilename(imageOriginalFilename)
						.imageRenamedFilename(imageRenamedFilename)
						.imageType(imageType)
						.imageFileSize(upFile.getSize())
						.build();

				// log.debug("review attach = {}", attach);
				attachments.add(attach);
				hasImage = true; // 이미지가 있으면 true (예라)
			}
		}
		
		// 2. db저장
		ReviewDetails reviews = ReviewDetails.builder()
				.reviewId(_review.getReviewId())
				.petId(pet.getPetId())
				.productId(_review.getProductId()) // 리뷰작성할 때 productId 넘기기 (예라)
				.reviewMemberId(_review.getReviewMemberId())
				.reviewStarRate(_review.getReviewStarRate())
				.reviewTitle(_review.getReviewTitle())
				.reviewContent(_review.getReviewContent())
				.attachments(attachments)
				.build();

		
		// petId 연결하기
//		String memberId = principal.getName();
//		List<Pet> petInfo = petService.findPetsByMemberId(memberId); // 로그인 한 회원의 펫정보 가져오기

		// petId 로그인 멤버 말고 리뷰작성자랑 연결하기
		String memberId = _review.getReviewMemberId();
		List<Pet> petInfo = petService.findPetsByMemberId(memberId); // 리뷰작성자의 펫정보 가져오기
		
		// log.debug("petInfo = {}", petInfo);
		
		if (!petInfo.isEmpty()) { // 펫정보가 비어있지 않다면
			Pet firstPet = petInfo.get(0); // 첫번째 Pet 객체 가져오기
			reviews.setPetId(firstPet.getPetId()); // db에 pet정보 저장 
		}

		log.debug("리뷰 이미지 확인 reviews = {}", reviews);
		
		// 상품 - 리뷰 연결
		// Product 객체 생성
		Product product = new Product();
		List<Product> findProduct = productService.findProduct(); // 모든 product 가져오기
		
		log.debug("findProduct = {}", findProduct); 
		
		for(Product p : findProduct) {
			product.setProductId(p.getProductId());
		}
		
		int reviewId = reviewService.insertReview(reviews);
		
		log.debug("_review = {}", _review);
		ReviewDetailDto pointReviewId = reviewService.findReviewId(reviews.getReviewId());

		
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
		
		// log.debug("newPoint = {}", newPoint);
		int newPointResult = pointService.insertPoint(newPoint);

		return "redirect:/review/reviewList.do";
	}

	// 리뷰 삭제
	@PostMapping("/reviewDelete.do")
	public String reviewDelete(@RequestParam int reviewId) {

		// 1. 리뷰 id로 적립된 포인트 찾기
		Point earnedPoint = pointService.getPointByReviewId(reviewId);
		// log.debug("earnedPoint = {}", earnedPoint);

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
			
			// log.debug("rollbackPoint = {}", rollbackPoint);

			int rollbackResult = pointService.insertRollbackPoint(rollbackPoint);
		}

		// 리뷰 삭제
		int result = reviewService.reviewDelete(reviewId);

		return "redirect:/review/reviewList.do";
	}


	// 리뷰 상세조회 
	@GetMapping("/reviewDetail.do")
	public void reviewDetail(
			@RequestParam(required=true) int reviewId, 
			Model model, 
			Pet pet, 
			Principal principal) {
		
		ReviewDetailDto reviews = reviewService.findReviewId(reviewId);
		model.addAttribute("reviews", reviews);

		// log.debug("펫정보 reviews 가져올수있니 = {}", reviews);
		
		// 이미지 파일 정보 조회
		ReviewDetails reviewDetails = reviewService.findImageAttachmentsByReviewId(reviewId);
		// log.debug("reviewDetails = {}", reviewDetails);
		model.addAttribute("reviewDetails", reviewDetails);
		
	}


	// 리뷰 수정 페이지 이동
	@GetMapping("/reviewUpdate.do")
	public void reviewUpdate(@RequestParam int reviewId, Model model) {

		ReviewDetailDto reviews = reviewService.findReviewId(reviewId);
		model.addAttribute("reviews", reviews);

	}

	// 리뷰 수정
	@PostMapping("/reviewUpdate.do")
	public String updateReview(ReviewUpdateDto _review) {

		Review reviews = _review.toReview();
		int result = reviewService.updateReview(reviews);

		// log.debug("리뷰수정 result = {}", result);

		return "redirect:/review/reviewDetail.do?reviewId=" + reviews.getReviewId();

	}



}