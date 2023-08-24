package com.shop.app.product.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
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
import com.shop.app.product.dto.ProductCreateDto;
import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.service.ProductService;
import com.shop.app.review.entity.Review;
import com.shop.app.review.service.ReviewService;
import com.shop.app.wishlist.service.WishlistService;

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
	private WishlistService wishlistService;
	
	
	// 상품 상세페이지 리뷰 연결
	@GetMapping("/productDetail.do")
	public void productDetail(
			@Valid ProductInfoDto productInfoDto,
			@AuthenticationPrincipal MemberDetails member,
			@RequestParam(defaultValue = "1") int page,
			Model model) {
		
		int limit = 3;
		
		Map<String, Object> params = Map.of(
				"page", page,
				"limit", limit
				);

		int totalCount = reviewService.findProductTotalReviewCount();
		int totalPages = (int) Math.ceil((double) totalCount / limit);
		model.addAttribute("totalPages", totalPages);

		List<Review> reviews = reviewService.findProductReviewAll(params);

		log.debug("토탈카운트 = {} ", totalCount);
		log.debug("페이지, 리밋, 멤버아이디 params = {}", params);
		log.debug("파람스 들어가있는거 reviews = {}", reviews);
//		log.debug("펫아이디 들어가있는거 petId = {}", petId);

		model.addAttribute("reviews", reviews);
		
		// 상품 정보 가져오기
		model.addAttribute("productInfo", productService.findProductById(productInfoDto.getProductId()));
		
		// 찜 여부 가져오기
		model.addAttribute("likeState", wishlistService.getLikeProduct(productInfoDto.getProductId(), member.getMemberId()));
	}
	
	@GetMapping("/productList.do")
	public void productList() {
		
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
