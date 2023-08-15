package com.shop.app.cart.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.cart.entity.CartItemDetails;
import com.shop.app.cart.repository.CartRepository;
import com.shop.app.member.entity.Member;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductDetail;
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
	public CartInfoDto getCartList(String memberId) {
		// 1. 멤버 아이디로 카트(cart) 조회 (쿼리문 쪼인처리하면 될듯)
		List<CartItem> cartItemList = cartRepository.getCartList(memberId);
		log.debug("cartItem codeList = {}", cartItemList);
		
		// cartItem에 담긴 모든 product_detail_id를 가지고 product_detail 테이블을 조회해야 함
		// Map<ProductDetail, 구매수량> 하면 될 것같음
		// sql은 in으로 하면 될 듯
		Map<ProductDetail, Integer> productInfo = new HashMap<>();
		Map<Product, Integer> priceInfo = new HashMap<>();

		for(int i=0; i <cartItemList.size(); i++) {
			ProductDetail product = productRepository.findProductDetailById(cartItemList.get(i).getProductDetailId());
			productInfo.put(product, cartItemList.get(i).getQuantity());
			
			// 상품, 상품가격 가져와서 넣기~
			// int price = productRepository.getPrice(product.getProductId());
			
			// priceInfo.put(productRepository.findProductDetailById(i), null);
		}
		
		log.debug("productInfo = {}", productInfo);
		

		return null;
	}

}
