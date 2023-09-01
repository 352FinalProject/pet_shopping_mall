package com.shop.app.cart.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PurchaseDto {
	private int productId;
	private int productDetailId; 
	private String productName; 
	private String optionName; 
	private String optionValue; 
	private int productPrice;
	private int additionalPrice; 
	private int quantity; 
	
	private String thumbnail;
}
