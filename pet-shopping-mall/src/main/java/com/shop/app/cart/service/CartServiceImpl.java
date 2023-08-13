package com.shop.app.cart.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.cart.dto.CartDto;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.cart.entity.CartItemDetails;
import com.shop.app.cart.repository.CartRepository;
import com.shop.app.member.entity.Member;
import com.shop.app.product.entity.Product;
import com.shop.app.product.repository.ProductRepository;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class CartServiceImpl implements CartService {

	@Autowired
	private ProductRepository productRepository;
	
	@Autowired
	private CartRepository cartRepository;
	
	
	@Override
	public CartItemDetails getCartList(String memberId) {
		List<CartItem> cartItemList = cartRepository.getCartList(memberId);
		log.debug("cartItem codeList = {}", cartItemList);
		// cartItem에 담긴 모든 product_code를 가지고
		// product 테이블을 조회해야 함
		Product product = null;
		
		CartItemDetails cartItemDetails = 
				CartItemDetails.builder()
				.cartList(new HashMap<>())
				.build();
		
		for(CartItem item : cartItemList) {
			product = productRepository.findProductByCode(item.getProductCode());
			// cartItemDetails에 있는 Map에 Product 세팅 / 구매수량 세팅
			log.debug("product = {}", product);
			cartItemDetails.getCartList().put(product, item.getQuantity());
			log.debug("cartItemDetails = {}", cartItemDetails);
		}
		return cartItemDetails;
	}

}