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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.service.MemberService;
import com.shop.app.order.service.OrderService;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.service.PetService;
import com.shop.app.product.dto.ProductCreateDto;
import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.dto.ProductSearchDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.entity.ProductImages;
import com.shop.app.product.service.ProductService;
import com.shop.app.review.dto.ProductReviewAvgDto;
import com.shop.app.review.dto.ReviewCreateDto;
import com.shop.app.review.dto.ReviewDetailDto;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;
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
	private OrderService orderService;

   @Autowired
   private ReviewService reviewService;
   
   @Autowired
   private WishlistService wishlistService;

   @Autowired
   private PetService petService;

   @GetMapping("/productDetail.do")
   public void productDetail(@RequestParam int productId,
                             @RequestParam(defaultValue = "1") int page,
                             @AuthenticationPrincipal MemberDetails member,
                             Model model) {

       int limit = 3;
       Map<String, Object> params = Map.of("page", page, "limit", limit);

       int totalCount = reviewService.findProductTotalReviewCount();
       int totalPages = (int) Math.ceil((double) totalCount / limit);
       model.addAttribute("totalPages", totalPages);

       List<Review> reviews = reviewService.findProductReviewAll(params, productId);
       model.addAttribute("reviews", reviews);

       // 상품 아이디로 정보 가져오기
       Product product = productService.findProductById(productId);
       List<ProductDetail> productDetails = productService.findAllProductDetailsByProductId(productId);
       ProductImages productImages = productService.findImageAttachmentsByProductId(productId);
       log.debug("productDetails = {}", productDetails);
       log.debug("productImages = {}", productImages);
       
       // 상품정보 담아주기
       model.addAttribute("product", product); // 상품정보
       model.addAttribute("productImages", productImages); // 상품이미지
       model.addAttribute("productDetails", productDetails); // 상품옵션
       
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
	        
	        if (reviewDetails.getAttachments() != null && !reviewDetails.getAttachments().isEmpty()) {
	            String imageFilename = reviewDetails.getAttachments().get(0).getImageRenamedFilename();
	            //log.debug("imageFilename = {}", imageFilename);
	            reviewImageMap.put(reviewId2, imageFilename);
	        }
	    }
	    
	    model.addAttribute("reviewImageMap", reviewImageMap); // 이미지 정보
	    model.addAttribute("reviewPetsMap", reviewPetsMap); // 펫정보
	    
	    // 리뷰 전체개수 확인
	    int reveiwTotalCount = reviewService.findReviewTotalCount(productId);
	    model.addAttribute("reviewTotalCount", reveiwTotalCount);
	    
	    // log.debug("reveiwTotalCount = {}", reveiwTotalCount);
	    
	    // 리뷰 평점
//		List<ProductReviewAvgDto> reviews2 = reviewService.findProductReviewAvgAll(productId);
//		model.addAttribute("reviews2", reviews2);
//		  
//		log.debug("reviews2 = {} ", reviews2);
//		  
//		ProductReviewAvgDto productReviewStarAvg = reviewService.productReviewStarAvg(productId);
//		model.addAttribute("productReviewStarAvg", productReviewStarAvg);
////	
//		log.debug("productReviewStarAvg = {}", productReviewStarAvg);
//		  
		 
	    
	    
	    /* 찜 등록 여부 가져오기 (선모) */
		model.addAttribute("likeState", wishlistService.getLikeProduct(productId, member.getMemberId()));
		}

	/**
	 * @author 전수경
	 * - 상품게시판 연결
	 */
	@GetMapping("/productList.do")
	public void productList(
			@RequestParam int id,
			Model model
			) {
		log.debug("categoryId = {}", id);
		// 카테고리 정보 가져오기
		ProductCategory productCategory = productService.findProductCategoryById(id); 
		// 해당 카테고리의 상품 가져오기
		List<Product> products = productService.findProductsByCategoryId(id);
		
		List<ProductInfoDto> productInfos = new ArrayList<ProductInfoDto>();
		for(Product product : products) {
			// 이미지 가져오기
			ProductImages productImages = productService.findImageAttachmentsByProductId(product.getProductId());
			List<ProductDetail> productDetails = productService.findAllProductDetailsByProductId(product.getProductId());
			// 상품 주문정보 가져오기
			int orderCnt = 0;
			for(ProductDetail productDetail : productDetails) {
				orderCnt += orderService.findOrderCntByProductId(productDetail.getProductDetailId());
			}
			
			productInfos.add(ProductInfoDto.builder()
					.product(product)
					.productDetails(productDetails)
					.productId(product.getProductId()) // productId 받아오기 (혜령)
					.orderCnt(orderCnt) // 주문수
					.attachments(productImages.getAttachments())
					.attachmentMapping(productImages.getAttachmentMapping())
					.build());
		}
		log.debug("productInfos = {}", productInfos);
		
		model.addAttribute("productCategory", productCategory);
		model.addAttribute("productInfos", productInfos);
		
		// 리뷰 전체개수 출력 (혜령)
		for (ProductInfoDto productInfo : productInfos) {
		    int productId = productInfo.getProductId();

		    int productListReviewTotalCount = reviewService.findProductListReviewTotalCount(productId);
		    productInfo.setReviewCnt(productListReviewTotalCount);
		}
		model.addAttribute("productInfos", productInfos); 
   }
   
   
   /* 하트 클릭 (선모) */
   @ResponseBody
   @PostMapping("/insertPick.do")
   public Map insertPick(@Valid @RequestBody Map<String, Object> param, @AuthenticationPrincipal MemberDetails member) {
      Map<String, Object> resultMap = new HashMap<>();
      String state = "insert".equals(param.get("state").toString()) ? "등록" : "삭제";
      String getProductId = param.get("productId").toString();
      int productId = getProductId.isEmpty() ? 0 : Integer.parseInt(getProductId);
      resultMap.put("rs", "fail");
      resultMap.put("msg", "찜 " + state + "에 실패하였습니다.");
      
      if(productId != 0) {
         // 데이터 Setting
         param.put("productId", productId);
         
         if("insert".equals(param.get("state").toString())) {
            param.put("cnt", 1);
            
            if(wishlistService.insertPick(productId, member.getMemberId()) > 0) {
               if(productService.updateLikeCnt(param) > 0) {
                  resultMap.put("rs", "insertS");
                  resultMap.put("msg", "찜 " + state + "에 성공하였습니다.");
               }
            }
         } else if("delete".equals(param.get("state").toString())) {
            param.put("cnt", -1);
            
            if(wishlistService.deletePick(productId, member.getMemberId()) > 0) {
               if(productService.updateLikeCnt(param) > 0) {
                  resultMap.put("rs", "deleteS");
                  resultMap.put("msg", "찜 " + state + "에 성공하였습니다.");
               }
            }
         }
      }
      return resultMap;
   }
   
   @GetMapping("/searchProduct.do")
   public void searchProducts(Model model, @RequestParam String searchQuery) {
      List<ProductSearchDto> productInfos = productService.searchProducts(searchQuery);
      model.addAttribute("productInfos",productInfos);
      
   }
   
}