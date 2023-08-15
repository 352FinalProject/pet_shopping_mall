package com.shop.app.cart.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.entity.CartItemDetails;
import com.shop.app.cart.service.CartService;
import com.shop.app.product.entity.ProductDetail;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/cart")
@Controller
public class CartController {

	@Autowired
	private CartService cartService;
	
	
	@GetMapping("/shoppingCart.do")
	public void getCartList(Model model) {
		// 멤버꺼만 보여야하니까 @PathVariabl("memberId")? 고민좀
		String memberId = "honggd";
		CartInfoDto cart = cartService.getCartList(memberId);
		model.addAttribute("cart",cart);
		
	}
}
