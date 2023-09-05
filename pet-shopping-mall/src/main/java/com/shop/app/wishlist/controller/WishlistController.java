package com.shop.app.wishlist.controller;

import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.shop.app.member.entity.MemberDetails;
import com.shop.app.review.dto.ProductReviewAvgDto;
import com.shop.app.review.service.ReviewService;
import com.shop.app.wishlist.entity.Wishlist;
import com.shop.app.wishlist.service.WishlistService;

@Slf4j
@Validated
@RequestMapping("/wishlist")
@Controller
public class WishlistController {	
	@Autowired
    private WishlistService wishlistService;	
	@Autowired
    private ReviewService reviewService;
	/**
	 * @author 강선모
	 * 찜목록 페이지 이동 
	 */
    @GetMapping("/myWishlist.do")
  
    public void myWishlist(@RequestParam(defaultValue = "1") int page, @AuthenticationPrincipal MemberDetails member,Model model) {

    	int limit = 5;
		
		Map<String, Object> params = Map.of(
		
			"page", page,
			"limit", limit,
			"memberId", member.getMemberId()
		);    	
		int totalCount = wishlistService.getListCount(params);
		
		int totalPages = (int) Math.ceil((double) totalCount / limit);
		
		model.addAttribute("totalPages", totalPages);	
		
		List<Map<String, Object>> list = wishlistService.getMyWishList(params);	
		for(int i=0; i<list.size(); i++) {
			
			ProductReviewAvgDto productReviewStarAvg = reviewService.productReviewStarAvg(Integer.parseInt(list.get(i).get("PRODUCT_ID").toString()));
			
	        list.get(i).put("avg", productReviewStarAvg != null ? productReviewStarAvg.getReviewStarRate() : "0.0");
		}
		
		/**
		 * @author 강선모
    	 * 찜 목록 가져오기 
		 */
    	model.addAttribute("myWishList", list);  	
    }  
}
