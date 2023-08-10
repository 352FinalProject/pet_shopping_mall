package com.shop.app.cart.entity;

import java.util.List;
import java.util.Map;

import com.shop.app.member.entity.Member;
import com.shop.app.product.entity.Product;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartItemDetails extends CartItem {
	private Member member;
	private Map<Product, Integer> cartList; // 제품 객체와 구매 수량을 세팅
}
