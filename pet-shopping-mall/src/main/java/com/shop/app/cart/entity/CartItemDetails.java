package com.shop.app.cart.entity;

import java.util.List;
import java.util.Map;

import com.shop.app.member.entity.Member;
import com.shop.app.product.entity.Product;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class CartItemDetails extends CartItem {
	// 상품 상세 / 상품 / 상품 이미지
	//
	int id;
}
