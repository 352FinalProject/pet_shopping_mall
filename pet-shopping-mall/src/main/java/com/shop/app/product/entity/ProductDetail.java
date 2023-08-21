package com.shop.app.product.entity;

import javax.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductDetail {
	private int productDetailId;
	private int productId;
	private String optionName;
	private String optionValue;
	private int additionalPrice;
	private int sale_state; // default=0(판매대기) 1: 판매중 2: 품절 3: 기타
}
