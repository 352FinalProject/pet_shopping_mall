package com.shop.app.product.dto;

import com.shop.app.product.entity.ProductDetail;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDetailUpdateDto {
    private int productDetailId;
    private String optionName;
    private String optionValue;
    private int additionalPrice;
    private int saleState;
    
    public ProductDetail toProductDetail() {
    	return ProductDetail.builder()
    			.productDetailId(productDetailId)
    			.optionName(optionName)
    			.optionValue(optionValue)
    			.additionalPrice(additionalPrice)
    			.saleState(saleState)
    			.build();
    }
}
