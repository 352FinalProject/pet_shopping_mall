package com.shop.app.cart;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/cart")
@Controller
public class CartController {

	@GetMapping("/shoppingCart.do")
	public void cart() {}
}
