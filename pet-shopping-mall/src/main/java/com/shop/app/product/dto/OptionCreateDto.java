package com.shop.app.product.dto;

import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductOption;

import lombok.Data;

@Data
public class OptionCreateDto {
	private int productId;
	private String optionName;
	private String optionValue;
	
	public ProductOption toProductOption() {
		return ProductOption.builder()
				.productId(productId)
				.optionName(optionName)
				.optionValue(optionValue)
				.build();
	}
}
