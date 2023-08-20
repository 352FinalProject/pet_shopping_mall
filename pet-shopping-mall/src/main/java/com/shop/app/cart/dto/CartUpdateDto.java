package com.shop.app.cart.dto;

import com.shop.app.cart.entity.CartItem;

import lombok.Data;

@Data
public class CartUpdateDto {
	private int cartitemId;
	private int productDetailId;
	private int quantity;
	
	public CartItem toCartitem() {
		return CartItem.builder()
				.cartitemId(cartitemId)
				.productDetailId(productDetailId)
				.quantity(quantity)
				.build();
	}
}
