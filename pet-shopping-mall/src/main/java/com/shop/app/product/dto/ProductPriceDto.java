package com.shop.app.product.dto;


import lombok.Data;

@Data
public class ProductPriceDto { // 상품명이랑 가격 가져오기 위해서 만든 DTO
	private String productName;
	private int productPrice;
}
