package com.shop.app.cart.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.cart.repository.CartRepository;
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
	public List<CartInfoDto> getCartInfoList(String memberId) {
		List<CartItem> cartItemList = cartRepository.getCartList(memberId);
		log.debug("cartItem codeList = {}", cartItemList);
		
		List<CartInfoDto> cartInfoList = new ArrayList<>();
		
		CartInfoDto product = null;
		
		for(int i=0; i <cartItemList.size(); i++) {
			product = cartRepository.getCartInfoList(cartItemList.get(i).getProductDetailId());
			cartInfoList.add(product);
		}

		return cartInfoList;
	}

}
