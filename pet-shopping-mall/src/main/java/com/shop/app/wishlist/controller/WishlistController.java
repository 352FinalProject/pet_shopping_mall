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
import com.shop.app.wishlist.service.WishlistService;


@Slf4j
@Validated
@RequestMapping("/wishlist")
@Controller
public class WishlistController {
	
	@Autowired
    private WishlistService wishlistService;
    
	// 찜목록 페이지 이동 (선모)
    @GetMapping("/myWishlist.do")
    public void myWishlist( @AuthenticationPrincipal MemberDetails member,Model model) {
    	// 찜 목록 가져오기
    	model.addAttribute("myWishList", wishlistService.getMyWishList(member.getMemberId()));
    }
}



