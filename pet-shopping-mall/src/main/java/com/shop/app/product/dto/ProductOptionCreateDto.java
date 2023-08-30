package com.shop.app.product.dto;

import com.shop.app.product.entity.ProductDetail;

import lombok.Data;

@Data
public class ProductOptionCreateDto {
	private int productId;
	private String optionName;
	private String optionValue;
	private int additionalPrice;
	private int saleState;
	
    public ProductDetail toProductDetail() {
    	return ProductDetail.builder()
    			.optionName(optionName)
    			.optionValue(optionValue)
    			.additionalPrice(additionalPrice)
    			.saleState(saleState)
    			.build();
    }

}
