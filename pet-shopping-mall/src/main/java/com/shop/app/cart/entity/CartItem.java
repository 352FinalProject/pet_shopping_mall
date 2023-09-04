package com.shop.app.cart.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@NoArgsConstructor
@AllArgsConstructor
@Data
@SuperBuilder
public class CartItem {
	private int cartitemId;
	private int cartId;
	private int productDetailId;
	private int quantity;
}
