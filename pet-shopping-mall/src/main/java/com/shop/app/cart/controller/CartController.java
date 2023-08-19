package com.shop.app.cart.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.service.CartService;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.service.MemberService;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/cart")
@Controller
public class CartController {

	@Autowired
	private CartService cartService;
	
	@Autowired
	private PointService pointService;
	
	@GetMapping("/shoppingCart.do")
	public void getCartList(Model model, Authentication authentication, @AuthenticationPrincipal MemberDetails member) {
		MemberDetails principal = (MemberDetails) authentication.getPrincipal();
		List<CartInfoDto> cartList = cartService.getCartInfoList(principal.getMemberId());
		
		Point point = pointService.findCurrentPointById(principal.getMemberId());

		model.addAttribute("cartList", cartList);
		model.addAttribute("pointCurrent", point.getPointCurrent());
	}
	
	@PostMapping("/deleteCartOne.do")
	public String deleteOne(@RequestParam("id") String _id, RedirectAttributes redirectAttr, 
			Authentication authentication, @AuthenticationPrincipal MemberDetails member) {
		int id = Integer.parseInt(_id);
		String memberId = member.getMemberId();
		int result = cartService.deleteCartOne(id, memberId);
		return "redirect:/cart/shoppingCart.do";
	}
	
	@PostMapping("/deleteCartAll.do")
	public String deleteCartAll(RedirectAttributes redirectAttr, 
			Authentication authentication, @AuthenticationPrincipal MemberDetails member) {
		
		String memberId = member.getMemberId();
		int result = cartService.deleteCartAll(memberId);
		return "redirect:/cart/shoppingCart.do";
	}
}
