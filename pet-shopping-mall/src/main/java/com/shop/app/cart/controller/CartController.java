package com.shop.app.cart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.dto.CartUpdateDto;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.cart.service.CartService;
import com.shop.app.member.entity.MemberDetails;
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
	
	
	/**
	 * @author 김담희
	 * 로그인 중인 회원의 개인 장바구니 정보 조회
	 */
	@GetMapping("/shoppingCart.do")
	public void getCartList(Model model, @AuthenticationPrincipal MemberDetails member) {
		String memberId = member.getMemberId();
		List<CartInfoDto> cartList = cartService.getCartInfoList(memberId);
		
		Point point = pointService.findCurrentPointById(memberId);

		model.addAttribute("cartList", cartList);
		model.addAttribute("pointCurrent", point.getPointCurrent());

	}
	
	
	/**
	 * @author 김담희
	 * 로그인 중인 회원의 장바구니 목록을 단순 조회
	 * 상품 페이지에서 장바구니에 넣기 버튼을 클릭했을 때, ajax 요청으로 장바구니 안 상품을 조회하여
	 * 중복 상품일 시 update, 장바구니에 없을 시 insert 처리 하기 위해서 조회 용으로 만듦
	 */
	@GetMapping("/getCartList.do")
	public ResponseEntity<?> getCartList(@AuthenticationPrincipal MemberDetails member) {
		List<CartInfoDto> cartList = cartService.getCartInfoList(member.getMemberId());
		return ResponseEntity.ok(cartList);
	}
	
	
	/**
	 * @author 김담희
	 * 장바구니 안의 물건을 하나만 삭제
	 */
	@PostMapping("/deleteCartOne.do")
	public String deleteOne(@RequestParam("cartitemId") String _id, RedirectAttributes redirectAttr, 
			Authentication authentication, @AuthenticationPrincipal MemberDetails member) {
		int cartitemId = Integer.parseInt(_id);
		String memberId = member.getMemberId();
		int result = cartService.deleteCartOne(cartitemId, memberId);
		return "redirect:/cart/shoppingCart.do";
	}
	
	/**
	 * @author 김담희
	 * 장바구니 안의 물건을 모두 삭제
	 */
	@PostMapping("/deleteCartAll.do")
	public String deleteCartAll(RedirectAttributes redirectAttr, 
			Authentication authentication, @AuthenticationPrincipal MemberDetails member) {
		
		String memberId = member.getMemberId();
		int result = cartService.deleteCartAll(memberId);
		return "redirect:/cart/shoppingCart.do";
	}
	
	
	/**
	 * @author 김담희
	 * 장바구니에서 상품 옵션 변경을 클릭했을 때, 해당 상품이 가진 모든 옵션을 조회
	 */
	@ResponseBody
	@GetMapping("/findProductOptionById.do")
	public List<CartInfoDto> findProductOptionById(@RequestParam("id") String _id) {
		int id = Integer.parseInt(_id);
		List<CartInfoDto> productInfo =  cartService.findProductOptionById(id);
		return productInfo;
	}
	
	
	/**
	 * @author 김담희
	 * 장바구니 안의 상품을 사용자가 선택한 옵션값으로 변경
	 */
	@ResponseBody
	@PostMapping("/updateCart.do")
	public int updateCart(CartUpdateDto _cartitem) {
		String memberId = _cartitem.getMemberId();
		CartItem cartitem = _cartitem.toCartitem();
		int result = cartService.updateCart(cartitem, memberId);
		
		return result;
	}
	
	
	/**
	 * @author 김담희
	 * 상품 상세 페이지에서 사용자가 선택한 옵션(productDetail)과 수량을 입력받아 장바구니에 추가
	 */
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
