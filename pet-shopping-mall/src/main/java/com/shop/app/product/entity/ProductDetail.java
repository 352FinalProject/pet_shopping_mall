package com.shop.app.product.entity;

import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class ProductDetail {
	@NotNull
	private int productDetailId;
	@NotNull
	private int product_id;
	
	private String option;
	private String optionValue;
	
	private int additionalPrice;
	private int stock;
	private int sale_state; // default=0(판매대기) 1: 판매중 2: 품절 3: 기타
}
