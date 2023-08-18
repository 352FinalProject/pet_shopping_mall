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
	private int cartId; // 참조하고 있는 장바구니 아이디
	private int productDetailId;
	private int quantity;
}
