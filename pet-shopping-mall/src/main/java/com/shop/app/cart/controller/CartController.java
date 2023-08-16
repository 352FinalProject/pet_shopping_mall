package com.shop.app.cart.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.service.CartService;
import com.shop.app.member.entity.MemberDetails;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/cart")
@Controller
public class CartController {

	@Autowired
	private CartService cartService;
	
	
	@GetMapping("/shoppingCart.do")
	public void getCartList(Model model, Authentication authentication, @AuthenticationPrincipal MemberDetails member) {
		MemberDetails principal = (MemberDetails) authentication.getPrincipal();
		CartInfoDto cart = cartService.getCartList(principal.getMemberId());
		log.debug("cart = {}", cart);
		model.addAttribute("cart",cart);
		
	}
}
