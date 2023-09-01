package com.shop.app.product.controller;

import java.lang.reflect.Member;
import java.security.Principal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.service.MemberService;
import com.shop.app.order.dto.OrderReviewListDto;
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

       int limit = 5;
       
       Map<String, Object> params = Map.of(
    		   "page", page, 
    		   "limit", limit);

       int totalCount = reviewService.findProductTotalReviewCount(productId);
       
       log.debug("totalCount 몇개임 = {}", totalCount);
       
       int totalPages = (int) Math.ceil((double) totalCount / limit);
       model.addAttribute("totalPages", totalPages);
       
       // 상품Id에 대한 모든 리뷰 가져오기
       List<Review> reviews = reviewService.findProductReviewAll(params, productId);
       model.addAttribute("reviews", reviews);
       
       // 별점 퍼센트
       List<Review> allReviews = reviewService.findProductReviewAllNoPageBar(productId);
       
       int[] starCounts = new int[6];  
       for (Review review : allReviews) {
           int star = review.getReviewStarRate();
           starCounts[star]++;
       }

       int totalReviews = allReviews.size();

       double[] starPercentages = new double[6];  // 각 별점별 백분율을 저장할 배열
       
       for (int i = 1; i <= 5; i++) {
           starPercentages[i] = (double) starCounts[i] / totalReviews * 100;
       }

       model.addAttribute("starPercentages", starPercentages);

       // starPercentages 배열을 계산하고, 백분율로 변환하여 소수점 없이 포맷팅한 리스트를 생성
       List<String> formattedPercentages = new ArrayList<>();
       for (double percentage : starPercentages) {
           String formatted = new DecimalFormat("###").format(percentage); // 소수점 없이 포맷팅
           formattedPercentages.add(formatted);
       }

       model.addAttribute("formattedPercentages", formattedPercentages);

       // 상품 아이디로 정보 가져오기
       Product product = productService.findProductById(productId);
       List<ProductDetail> productDetails = productService.findAllProductDetailsByProductId(productId);
       ProductImages productImages = productService.findImageAttachmentsByProductId(productId);
       
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
       Map<Integer, List<String>> reviewImageMap = new HashMap<>();
       for (Review review : reviews) {
           int reviewId2 = review.getReviewId();
           ReviewDetails reviewDetails = reviewService.findProductImageAttachmentsByReviewId(reviewId2);
           
           log.debug("reviewDetails = {}", reviewDetails);
           
           if (reviewDetails.getAttachments() != null && !reviewDetails.getAttachments().isEmpty()) {
               List<String> imageFilenames = new ArrayList<>();
               
               for (ImageAttachment attachment : reviewDetails.getAttachments()) {
                   imageFilenames.add(attachment.getImageRenamedFilename());
               }
               reviewImageMap.put(reviewId2, imageFilenames);
           }
       }

	    model.addAttribute("reviewImageMap", reviewImageMap); // 이미지 정보
	    
	    // 리뷰 작성자 - 상품 
	    Map<Integer, List<OrderReviewListDto>> reviewProductMap = new HashMap<>();
	    	for (Review review : reviews) {
	    		List<OrderReviewListDto> ReviewOrders = orderService.findProductByReviewId(review.getReviewId(), productId);
	    		reviewProductMap.put(review.getReviewId(), ReviewOrders);
	    	}
	    
	    
	    log.debug("reviewImageMap = {}", reviewImageMap);

	    model.addAttribute("reviewPetsMap", reviewPetsMap); // 펫정보
	    model.addAttribute("reviewProductMap", reviewProductMap); // 구매자 상품정보
	    
	    // 상품 상세 페이지 - 리뷰 전체개수 확인
	    int reveiwTotalCount = reviewService.findReviewTotalCount(productId);
	    model.addAttribute("reviewTotalCount", reveiwTotalCount);
	    
	    // 리뷰 별점 평균
	    ProductReviewAvgDto productReviewStarAvg = reviewService.productReviewStarAvg(productId);
		model.addAttribute("productReviewStarAvg", productReviewStarAvg);
		
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
			Model model,
			@RequestParam(required = false) String align
			) {

		ProductCategory productCategory = productService.findProductCategoryById(id); 
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

		model.addAttribute("productInfos", productInfos);
		model.addAttribute("productCategory", productCategory);
		
		// 리뷰 전체개수, 리뷰 별점 평균 (혜령)
		for (ProductInfoDto productInfo : productInfos) {
		    int productId = productInfo.getProductId();

		    int productListReviewTotalCount = reviewService.findProductListReviewTotalCount(productId);
		    productInfo.setReviewCnt(productListReviewTotalCount);
		    
	        ProductReviewAvgDto productReviewStarAvg = reviewService.productReviewStarAvg(productId);
	        productInfo.setProductReviewStarAvg(productReviewStarAvg);
		}
		
		model.addAttribute("productInfos", productInfos); 
		
		// 정렬
		String alignType = "";
		String inOrder = "";
		
		if (align != null) {
		    List<ProductSearchDto> _productInfos = null;
		    if (align.equals("신상품")) {
		    	alignType = "byNewDate";
		        
		    } else if (align.equals("낮은가격")) {
		    	alignType = "byPrice";
		        inOrder = "asc";
		        
		    } else if (align.equals("높은가격")) {
		    	alignType = "byPrice";
		        inOrder = "desc";
		        
		    } else if (align.equals("별점높은순")) {
		    	alignType = "byHighReviewStar";
		        
		    } else {
		    	alignType = "byReviewCnt";
		    }
		    _productInfos = productService.alignProducts(id, alignType, inOrder);
		    model.addAttribute("alignProductInfos", _productInfos);
		}
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