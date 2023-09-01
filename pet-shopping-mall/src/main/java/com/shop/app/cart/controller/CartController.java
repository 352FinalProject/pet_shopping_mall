package com.shop.app.cart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.dto.CartUpdateDto;
import com.shop.app.cart.entity.Cart;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.cart.service.CartService;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.service.MemberService;
import com.shop.app.order.dto.OrderCreateDto;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.entity.ProductImages;

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
	public void getCartList(Model model, @AuthenticationPrincipal MemberDetails member) {
		String memberId = member.getMemberId();
		List<CartInfoDto> cartList = cartService.getCartInfoList(memberId);
		
		Point point = pointService.findCurrentPointById(memberId);

		model.addAttribute("cartList", cartList);
		model.addAttribute("pointCurrent", point.getPointCurrent());

	}
	
	@PostMapping("/deleteCartOne.do")
	public String deleteOne(@RequestParam("cartitemId") String _id, RedirectAttributes redirectAttr, 
			Authentication authentication, @AuthenticationPrincipal MemberDetails member) {
		int cartitemId = Integer.parseInt(_id);
		String memberId = member.getMemberId();
		int result = cartService.deleteCartOne(cartitemId, memberId);
		return "redirect:/cart/shoppingCart.do";
	}
	
	@PostMapping("/deleteCartAll.do")
	public String deleteCartAll(RedirectAttributes redirectAttr, 
			Authentication authentication, @AuthenticationPrincipal MemberDetails member) {
		
		String memberId = member.getMemberId();
		int result = cartService.deleteCartAll(memberId);
		return "redirect:/cart/shoppingCart.do";
	}
	
	
	// 장바구니 옵션 수정
	@ResponseBody
	@GetMapping("/findProductOptionById.do")
	public List<CartInfoDto> findProductOptionById(@RequestParam("id") String _id) {
		int id = Integer.parseInt(_id);
		List<CartInfoDto> productInfo =  cartService.findProductOptionById(id);
		return productInfo;
	}
	
	@ResponseBody
	@PostMapping("/updateCart.do")
	public int updateCart(CartUpdateDto _cartitem) {
		String memberId = _cartitem.getMemberId();
		CartItem cartitem = _cartitem.toCartitem();
		int result = cartService.updateCart(cartitem, memberId);
		
		return result;
	}
	
	
	@ResponseBody
	@PostMapping("/insertCart.do")
	public Map<String, Object> insertCart(@RequestParam("quantity") String _quantity, @RequestParam("productDetailId") String _productDetailId, @AuthenticationPrincipal MemberDetails member) {
		String memberId = member.getMemberId();
		
		int quantity = Integer.parseInt(_quantity);
		int productDetailId = Integer.parseInt(_productDetailId);
		
		int result = cartService.insertCart(memberId, productDetailId, quantity);
		
		Map<String, Object> map = new HashMap<>();
		map.put("msg", "상품 추가 완료");
		return map;
	}
}
