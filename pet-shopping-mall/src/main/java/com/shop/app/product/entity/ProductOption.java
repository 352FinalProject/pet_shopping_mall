package com.shop.app.product.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductOption {
	private int optionId;
	private int productId;
	private String optionName;
	private String optionValue;

}
