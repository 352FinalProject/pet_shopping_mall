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
    //요청 파라미터로 현재 페이지 번호를 받아옵니다. 페이지 파라미터가 없을 경우 기본값으로 1을 사용합니다.
    public void myWishlist(@RequestParam(defaultValue = "1") int page, @AuthenticationPrincipal MemberDetails member,Model model) {
    	//한페이지에 노출될 요소 갯수 = 5개 -> 넘어가면 페이징 바 2로 넘어감	
    	int limit = 5;
		
		Map<String, Object> params = Map.of(
			//현재 페이지를 나타내는 파라미터, 사용자가 2를 요청하면 "page"파라미터에 2가 저장됨	
			"page", page,
			//한 페이지당 나타낼 요소 개수, 현 limit를 5로 설정 해놔서 한 페이지에 5개 요소(아이템)이 노출됨
			"limit", limit,
			//현재 로그인한 사용자의 회원 ID를 나타냄, 이 값으로 현재 로그인한 회원의 찜목록을 가지고옴.
			"memberId", member.getMemberId()
		);    	
		// "내 찜 목록"의 총 개수를 가지고 옴, totalCount 변수에 찜 목록의 총 개수를 저장합니다.
		int totalCount = wishlistService.getListCount(params);
		//Math.ceil 함수를 사용하여 소수점 아래 자리를 올림하여 정확한 페이지 수를 계산 ex)1.4 =2
		int totalPages = (int) Math.ceil((double) totalCount / limit);
		//계산된 총 페이지 수를 모델에 추가.
		model.addAttribute("totalPages", totalPages);	
		//wishlistService.getMyWishList(params) 를 호출하여 페이징된 "찜 목록" 데이터를 가지고옴
		List<Map<String, Object>> list = wishlistService.getMyWishList(params);	
		for(int i=0; i<list.size(); i++) {
			//찜목록에 저장된 리뷰평균 별점을 가지고 옴, list.get(i).get("PRODUCT_ID")를 통해 현재 아이템의 상품 ID를 가지고 오고 이를 이용하여 상품의 리뷰 평균 별점을 가지고 온다.
			ProductReviewAvgDto productReviewStarAvg = reviewService.productReviewStarAvg(Integer.parseInt(list.get(i).get("PRODUCT_ID").toString()));
			//각 아이템의 맵에 avg라는 키를 추가하고, 이 키에 리뷰 평균 별점을 저장한다. "0.0"은 만약 리뷰 평균 별점이 존재하지 않는 경우 "0.0"을 사용하도록 하는 조건문이다.
			//이를 통해 별점이 없는 상품의 경우 0.0을 기본값으로 설정해 에러를 방지한다.
	        list.get(i).put("avg", productReviewStarAvg != null ? productReviewStarAvg.getReviewStarRate() : "0.0");
		}
		
		/**
    	 * 찜 목록 가져오기 
		 */
		// 코드는 컨트롤러에서 처리한 결과를 모델에 추가하는 부분.
		// 컨트롤러에서 처리한 사용자의 찜 목록 데이터(list)를 모델에 추가하여 화면으로 전달하는 역할
    	model.addAttribute("myWishList", list);  	
    }  
}
