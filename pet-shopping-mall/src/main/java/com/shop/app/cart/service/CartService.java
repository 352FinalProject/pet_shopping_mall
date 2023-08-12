package com.shop.app.cart.service;

import java.util.List;

import com.shop.app.cart.dto.CartDto;
import com.shop.app.cart.entity.CartItemDetails;

public interface CartService {

	CartItemDetails getCartList(String memberId);

}
