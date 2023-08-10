package com.shop.app.cart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.cart.dto.CartDto;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.cart.entity.CartItemDetails;
import com.shop.app.cart.repository.CartRepository;
import com.shop.app.product.entity.Product;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class CartServiceImpl implements CartService {

	@Autowired
	private CartRepository cartRepository;
	
	@Override
	public CartItemDetails getCartList(String memberId) {
		List<CartItem> cartItemList = cartRepository.getCartList(memberId);
		log.debug("cartItem codeList = {}", cartItemList);
		// cartItem에 담긴 모든 product_code를 가지고
		// product 테이블을 조회해야 함
		CartItemDetails cartItemDetails = null;
		Product product = null;
		for(CartItem item : cartItemList) {
			// product = productRepository.findProductByCode(item.getProductCode());
			// cartItemDetails에 있는 Map에 Product 세팅 / 구매수량 세팅
			// 맵에 추가
		}
		return cartItemDetails;
	}

}
