package com.shop.app.cart.service;

import java.util.Map;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.product.entity.ProductDetail;

public interface CartService {

	CartInfoDto getCartList(String memberId);

}
