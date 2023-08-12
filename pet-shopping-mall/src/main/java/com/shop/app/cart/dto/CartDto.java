package com.shop.app.cart.dto;

import java.util.List;

import lombok.Data;

@Data
public class CartDto{
	private String memberId;
	// private List<Product> product;
	private int quantity;
	
}
