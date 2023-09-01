package com.shop.app.cart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CartOptionUpdateDto {
	
	private int productId;
    private int productDetailId;
    private String productName;
    private String optionName;
    private String optionValue;
    private String productPrice;
    private String additionalPrice;
    private String thumbnail;
	
}
