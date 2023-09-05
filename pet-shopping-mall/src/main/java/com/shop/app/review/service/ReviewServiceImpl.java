package com.shop.app.review.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.order.repository.OrderRepository;
import com.shop.app.order.service.OrderService;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.repository.PetRepository;
import com.shop.app.pet.service.PetService;
import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.repository.ProductRepository;
import com.shop.app.review.dto.ProductReviewAvgDto;
import com.shop.app.review.dto.ReviewDetailDto;
import com.shop.app.review.dto.ReviewListDto;
import com.shop.app.review.dto.ReviewProductDto;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;
import com.shop.app.review.repository.ReviewRepository;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private OrderService orderService;

	@Autowired
	private ReviewRepository reviewRepository;
	
	@Autowired
	private PetRepository petRepository;
	
	@Autowired
	private ProductRepository productRepository;
	
	@Autowired
	private OrderRepository orderRepository;
	
	
	// 리뷰추가
	@Override
	public int insertReview(Review review) {
		int result = 0;
		// review 저장
		result = reviewRepository.insertReview(review);
		int refId = review.getReviewId();
		
		// attachment 저장
		List<ImageAttachment> attachments = ((ReviewDetails) review).getAttachments();
		if(attachments != null && !attachments.isEmpty()) {
			for(ImageAttachment attach : attachments) {
				
				// 1. 이미지 파일 DB에 저장
				int result2 = reviewRepository.insertAttachment(attach);
				// 2. 이미지 파일 DB 저장 후 생성된 이미지 ID 가져오기
				int imageId = attach.getImageId();
				// 3. 리뷰 ID와 이미지 ID를 사용하여 매핑 정보를 DB에 저장
				int reviewIdImageId = reviewRepository.insertMapping(refId, imageId);
				
			}
		}
		int orderId = review.getOrderId();
		int productDetailId = review.getProductDetailId();
		int productId = review.getProductId();
		int newStatus = 6;
		orderRepository.updateOrderStatusWithDetail(orderId, productDetailId, newStatus, productId);
		
		return result;
	}

	// 리뷰 삭제
	@Override
	public int reviewDelete(int reviewId) {
		return reviewRepository.reviewDelete(reviewId);
	}

	// 내가 쓴 리뷰목록 조회
	@Override
	public List<ReviewListDto> findReviewAll(Map<String, Object> params) {
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
	@Transactional
	public ReviewDetailDto findReviewId(int reviewId) {
		Review review = reviewRepository.findReviewId(reviewId);
		
	    ReviewDetailDto reviewDetailDto = new ReviewDetailDto();
	    reviewDetailDto.setReviewId(review.getReviewId());
	    reviewDetailDto.setReviewTitle(review.getReviewTitle());
	    reviewDetailDto.setReviewContent(review.getReviewContent());
	    reviewDetailDto.setReviewStarRate(review.getReviewStarRate());
	    reviewDetailDto.setReviewCreatedAt(review.getReviewCreatedAt());

	    // 펫정보 연결
	    Integer petId = review.getPetId();

	    // 펫정보가 없는 경우
	    if (petId != null ) {
	    Pet pet = petRepository.findPetById(review.getPetId());
	    reviewDetailDto.setPetId(pet.getPetId());
	    reviewDetailDto.setPetName(pet.getPetName());
	    reviewDetailDto.setPetAge(pet.getPetAge());
	    reviewDetailDto.setPetBreed(pet.getPetBreed());
	    reviewDetailDto.setPetWeight(pet.getPetWeight());
	    reviewDetailDto.setPetGender(pet.getPetGender());
	    
	    } 
	    
	    return reviewDetailDto;
	}
	

	// 리뷰 상세조회 - 이미지 조회
	@Override
	public ReviewDetails findImageAttachmentsByReviewId(int reviewId) {
		return reviewRepository.findImageAttachmentsByReviewId(reviewId);
	}
	
	// 리뷰 상세조회 - 상품조회
	@Override
	public ReviewProductDto findProductReviewId(int reviewId) {
		return reviewRepository.findProductReviewId(reviewId);
	}

	// 리뷰 수정
	@Override
	public int updateReview(Review review) {
		return reviewRepository.updateReview(review);
	}

	@Override
	public ReviewDetails getDeleteReviewById(int reviewId) {
		return reviewRepository.getDeleteReviewById(reviewId);
	}
	
	
	// 상품 상세페이지 리뷰 전체 카운트
	@Override
	public int findProductTotalReviewCount(int productId) {
		return reviewRepository.findProductTotalReviewCount(productId);
	}

	// 상품 상세페이지 전체 리뷰 
	@Override
	public List<Review> findProductReviewAll(Map<String, Object> params, int productId) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return reviewRepository.findProductReviewAll(rowBounds, productId);
	}

	// 상품 상세페이지 - 리뷰 상세조회 - 이미지 조회
	@Override
	public ReviewDetails findProductImageAttachmentsByReviewId(int reviewId) {
		return reviewRepository.findProductImageAttachmentsByReviewId(reviewId);
	}

	@Override
	public ReviewDetails findImageAttachmentsByReviewMemberId(int reviewId) {
		return reviewRepository.findImageAttachmentsByReviewMemberId(reviewId);
	}

	@Override
	public String findImageFilenameByReviewId(int reviewId2) {
		return reviewRepository.findImageFilenameByReviewId(reviewId2);
	}

	@Override
	public Review findPoductListReviewId(int reviewId) {
		return reviewRepository.findPoductListReviewId(reviewId);
	}

	// 상품 - 리뷰 전체개수 확인
	@Override
	public int findReviewTotalCount(int productId) {
		return reviewRepository.findReviewTotalCount(productId);
	}

	// 상품 - 리뷰 평점
	@Override
	public ProductReviewAvgDto productReviewStarAvg(int productId) {
		return reviewRepository.productReviewStarAvg(productId);
	}

//	@Override
//	public List<ProductReviewAvgDto> findProductReviewAvgAll(int productId) {
//		return reviewRepository.findProductReviewAvgAll(productId);
//	}

	@Override
	public int findProductListReviewTotalCount(int productId) {
		return reviewRepository.findProductListReviewTotalCount(productId);
	}

	// 별점 퍼센트 구하기 위한 전체 리뷰
	@Override
	public List<Review> findProductReviewAllNoPageBar(int productId) {
		return reviewRepository.findProductReviewAllNoPageBar(productId);
	}

	@Override
	public ReviewDetails findProductImageAttachmentsByReviewId2(int reviewId2, int orderId) {
		return reviewRepository.findProductImageAttachmentsByReviewId2(reviewId2, orderId);
	}
//	@Override
//	public ReviewDetails findProductImageAttachmentsByReviewId2(int reviewId2) {
//		return reviewRepository.findProductImageAttachmentsByReviewId2(reviewId2);
//	}


}





