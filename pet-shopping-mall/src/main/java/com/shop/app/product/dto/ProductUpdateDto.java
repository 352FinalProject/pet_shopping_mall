package com.shop.app.product.dto;

import javax.validation.constraints.NotNull;

import com.shop.app.product.entity.Product;

import lombok.Data;
@Data
public class ProductUpdateDto {
	
	private int productId;
	private int categoryId;
	private String productName;
	private int productPrice;
	private int imageId;
	
	public Product toProduct() {
		return Product.builder()
				.productId(productId)
				.categoryId(categoryId)
				.productName(productName)
				.productPrice(productPrice)
				.imageId(imageId)
				.build();
	}
}
