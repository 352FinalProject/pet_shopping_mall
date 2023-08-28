package com.shop.app.cart.dto;

import com.shop.app.cart.entity.CartItem;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CartUpdateDto {
	private String memberId;
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
