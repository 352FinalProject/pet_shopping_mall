package com.shop.app.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Validated
@RequestMapping("/order")
@Controller
public class OrderController {

	@GetMapping("/orderHistory.do")
	public void orderHistory() {}
	
	@GetMapping("/orderCancle.do")
	public void orderCancle() {}
	
	
	
}
