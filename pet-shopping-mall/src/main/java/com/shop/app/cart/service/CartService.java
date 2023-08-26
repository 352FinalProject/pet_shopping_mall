package com.shop.app.cart.service;

import java.util.List;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.product.entity.ProductDetail;

public interface CartService {

	List<CartInfoDto> getCartInfoList(String memberId);

	int deleteCartOne(int cartitemId, String memberId);

	int deleteCartAll(String memberId);

	List<CartInfoDto> findProductOptionById(int id);

	int updateCart(CartItem cartitem);

	// 상품 페이지에서 장바구니 버튼 눌러서 장바구니에 담기 (예라)
	int insertCart(int cartId, int productDetailId, int quantity);

	
}
