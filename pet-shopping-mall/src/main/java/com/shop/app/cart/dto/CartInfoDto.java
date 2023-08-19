package com.shop.app.cart.dto;

import java.util.List;
import java.util.Map;

import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductDetail;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartInfoDto{
	private int cartitemId;
	private int productId;
	private int productDetailId; //product_detail
	private String productName; // product
	private String optionName; // product_detail
	private String optionValue; // product_detail
	private int productPrice;
	private int additionalPrice; // product.getProductPrice +  productDetail.additionalPrice
	private int quantity; // cartitemId
	
}
