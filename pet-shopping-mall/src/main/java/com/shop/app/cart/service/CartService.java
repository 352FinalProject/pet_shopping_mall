package com.shop.app.cart.service;

import java.util.List;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.product.entity.ProductDetail;

public interface CartService {

	List<CartInfoDto> getCartInfoList(String memberId);

	int deleteCartOne(int id, String memberId);

	int deleteCartAll(String memberId);

	List<ProductDetail> findProdById(int id);

	int updateCart(int productDetailId, int cartitemId, int quantity);
}
