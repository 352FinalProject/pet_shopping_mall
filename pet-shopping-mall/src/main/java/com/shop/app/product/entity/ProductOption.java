package com.shop.app.product.entity;

import lombok.Data;

@Data
public class ProductOption {
	private int optionId;
	private int productId;
	private String optionName;
	private String optionValue;

}
