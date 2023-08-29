package com.shop.app.cart.service;

import java.util.List;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.entity.Cart;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.product.entity.ProductDetail;

public interface CartService {

	List<CartInfoDto> getCartInfoList(String memberId);

	int deleteCartOne(int cartitemId, String memberId);

	int deleteCartAll(String memberId);

	List<CartInfoDto> findProductOptionById(int id);

	int updateCart(CartItem cartitem, String memberId);

	// 장바구니 찾기 (예라)
	int findCartById(String member);

	// 장바구니 담기 (담희)
	int insertCart(String memberId, int productDetailId, int quantity);
	
}
