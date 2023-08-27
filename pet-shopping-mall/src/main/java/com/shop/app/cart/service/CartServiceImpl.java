package com.shop.app.cart.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.entity.Cart;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.cart.repository.CartRepository;
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
	public List<CartInfoDto> getCartInfoList(String memberId) {
		List<CartItem> cartItemList = cartRepository.getCartList(memberId);
		List<CartInfoDto> cartInfoList = new ArrayList<>();
		
		CartInfoDto product = null;
		
		for(int i=0; i <cartItemList.size(); i++) {
			product = cartRepository.getCartInfoList(cartItemList.get(i).getProductDetailId());
			cartInfoList.add(product);
		}

		return cartInfoList;
	}


	@Override
	public int deleteCartOne(int cartitemId, String memberId) {
		return cartRepository.deleteCartOne(cartitemId, memberId);
	}


	@Override
	public int deleteCartAll(String memberId) {
		return cartRepository.deleteCartAll(memberId);
	}


	@Override
	public List<CartInfoDto> findProductOptionById(int id) {
		return cartRepository.findProductOptionById(id);
	}


	@Override
	public int updateCart(CartItem cartitem) {
		return cartRepository.updateCart(cartitem);
	}


	// 상품 페이지에서 장바구니 버튼 눌러서 장바구니에 담기 (예라)
	@Override
	public int insertCart(int cartId, int optionId, int productDetailId, int quantity) {
		return cartRepository.insertCart(cartId, optionId, productDetailId, quantity);
	}


	// 장바구니 찾기 (예라)
	@Override
	public int findCartById(String member) {
		return cartRepository.findCartById(member);
	}

}
