package com.shop.app.cart.service;

import java.util.List;

import com.shop.app.cart.dto.CartInfoDto;

public interface CartService {

	List<CartInfoDto> getCartInfoList(String memberId);

	int deleteCartOne(int id, String memberId);

	int deleteCartAll(String memberId);
}
