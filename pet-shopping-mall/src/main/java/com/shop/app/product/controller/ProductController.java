package com.shop.app.product.controller;

import java.lang.reflect.Member;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.service.MemberService;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.service.PetService;
import com.shop.app.product.dto.ProductCreateDto;
import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductImages;
import com.shop.app.product.service.ProductService;
import com.shop.app.review.dto.ReviewCreateDto;
import com.shop.app.review.dto.ReviewDetailDto;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;
import com.shop.app.review.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Validated
@RequestMapping("/product")
@Controller
public class ProductController {
	@Autowired
	private ProductService productService;

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private PetService petService;



	//	// 상품 상세페이지 리뷰 연결
	//	@GetMapping("/productDetail.do")
	//	public void productDetail(
	//			@RequestParam(defaultValue = "1") int page,
	//			@RequestParam(required=false) int reviewId,
	//			Model model,
	//			Pet pet,
	//			Principal principal) {
	//		
	//		int limit = 3;
	//		
	//		// 펫-리뷰 연결
	////		String memberId = _review.getReviewMemberId();
	////		List<Pet> petId = petService.findProductRevicePet(memberId);
	//		
	//		Map<String, Object> params = Map.of(
	//				"page", page,
	//				"limit", limit
	//				);
	//
	//		int totalCount = reviewService.findProductTotalReviewCount();
	//		int totalPages = (int) Math.ceil((double) totalCount / limit);
	//		
	//		List<Review> reviews = reviewService.findProductReviewAll(params);
	//		
	//		ReviewDetailDto productReviews = reviewService.findReviewId(reviewId);
	//		log.debug("productReviews = {}", productReviews);
	//		model.addAttribute("productReviews", productReviews);
	//		
	//		// 이미지 파일
	//		
	//		
	////		ReviewDetails reviewDetails = reviewService.findProductImageAttachmentsByReviewId(reviewId);
	//
	//		model.addAttribute("totalPages", totalPages);
	////		model.addAttribute("petId",  petId);
	////		model.addAttribute("reviewDetails", reviewDetails);
	//
	//		log.debug("토탈카운트 = {} ", totalCount);
	//		log.debug("페이지, 리밋, 멤버아이디 params = {}", params);
	////		log.debug("펫아이디 들어가있는거 petId = {}", petId);
	////		log.debug("리뷰이미지 파일 조회 = {}", reviewDetails);
	//
	//		
	//	}

	//	@GetMapping("/productDetail.do")
	//	public void productDetail(
	//	        @RequestParam(defaultValue = "1") int page,
	//	        @RequestParam(required=true) int reviewId,
	//	        Model model,
	//	        Pet pet,
	//	        Principal principal) {
	//
	//	    int limit = 3;
	//
	//	    	Map<String, Object> params = Map.of(
	//	            "page", page,
	//	            "limit", limit
	//	        );
	//
	//	        int totalCount = reviewService.findProductTotalReviewCount();
	//	        int totalPages = (int) Math.ceil((double) totalCount / limit);
	//
	//	        List<Review> reviews = reviewService.findProductReviewAll(params);
	//	        log.debug("params = {}", params);
	//
	//	        ReviewDetailDto productReviews = reviewService.findReviewId(reviewId);
	//	        log.debug("productReviews = {}", productReviews);
	//
	//	        model.addAttribute("productReviews", productReviews);
	//	        model.addAttribute("totalPages", totalPages);
	//	        
	//	        model.addAttribute("reviews", reviews);
	//	        
	//	        log.debug("토탈카운트 = {} ", totalCount);
	//	}

	@GetMapping("/productDetail.do")

	public void productDetail(@RequestParam int reviewId,
	                          @RequestParam(defaultValue = "1") int page,
	                          Model model) {

	    int limit = 3;
	    Map<String, Object> params = Map.of("page", page, "limit", limit);

	    int totalCount = reviewService.findProductTotalReviewCount();
	    int totalPages = (int) Math.ceil((double) totalCount / limit);
	    model.addAttribute("totalPages", totalPages);

	    List<Review> reviews = reviewService.findProductReviewAll(params);
	    model.addAttribute("reviews", reviews);

	    // 상품 상세 페이지에 펫 정보 뿌려주기
	    Map<Integer, List<Pet>> reviewPetsMap = new HashMap<>();

	    for (Review review : reviews) {
	        List<Pet> pets = petService.findReviewPetByMemberId(review.getReviewMemberId());
	        reviewPetsMap.put(review.getReviewId(), pets);
	    }
	    
	    // 상품 상세 페이지에 이미지 파일 뿌려주기
	    Map<Integer, String> reviewImageMap = new HashMap<>();
	    for (Review review : reviews) {
	        int reviewId2 = review.getReviewId();
	        ReviewDetails reviewDetails = reviewService.findProductImageAttachmentsByReviewId(reviewId2);
	        
	        log.debug("reviewDetails = {}", reviewDetails);
	        
	        if (reviewDetails.getAttachments() != null && !reviewDetails.getAttachments().isEmpty()) {
	            String imageFilename = reviewDetails.getAttachments().get(0).getImageRenamedFilename();
	            log.debug("imageFilename = {}", imageFilename);
	            reviewImageMap.put(reviewId2, imageFilename);
	        }
	    }
	    
	    log.debug("reviewImageMap = {}", reviewImageMap);
	    
	    model.addAttribute("reviewImageMap", reviewImageMap); // 이미지 정보
	    model.addAttribute("reviewPetsMap", reviewPetsMap); // 펫정보
	}


	@GetMapping("/productList.do")
	public void productList(
			@RequestParam int id,
			Model model
			) {
		log.debug("categoryId = {}", id);
		// 카테고리 정보 가져오기
		ProductCategory productCategory = productService.findProductCategoryById(id); 
		log.debug("productCategory = {}", productCategory);
		
		List<ProductInfoDto> productInfos = new ArrayList<ProductInfoDto>();
		
		// 해당 카테고리의 상품 가져오기
		List<Product> products = productService.findProductsByCategoryId(id);
		
		for(Product product : products) {
			ProductImages productImages = productService.findImageAttachmentsByProductId(product.getProductId());
			
			productInfos.add(ProductInfoDto.builder()
					.product(product)
					.attachments(productImages.getAttachments())
					.attachmentMapping(productImages.getAttachmentMapping())
					.build());
		}
		
		model.addAttribute("productCategory", productCategory);
		model.addAttribute("productInfos", productInfos);

	}

	@GetMapping("/addProduct.do")
	public void addProduct() {

	}

	@PostMapping("/addProduct.do")
	public String addProduct(
			@Valid ProductCreateDto _product,
			BindingResult bindingResult,
			@AuthenticationPrincipal MemberDetails member,
			Model model){
		log.debug("ProductCreateDto = {}", _product);
		//		
		//		Product product = _product.toProduct();
		//		log.debug("product = {}", product); // product = Product(productId=0, categoryId=1, productName=멍멍사료, productPrice=2000, thumbnailImg=0, productImg=0, createDate=null, expireDate=null, likeCnt=0, viewCnt=0)
		//		
		//		int result = productService.insertProduct(product);
		//		// There is no getter for property named 'category_id' in 'class com.shop.app.product.entity.Product'
		//		
		return "redirect:/admin/adminProductList.do";
	}


}
