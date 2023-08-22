package com.shop.app.product.dto;

import javax.validation.constraints.NotNull;

import com.shop.app.product.entity.Product;

public class ProductUpdateDto {
	@NotNull(message = "상품카테고리는 필수입력입니다.")
	private int categoryId;
	@NotNull(message = "상품명은 필수입력입니다.")
	private String productName;
	@NotNull(message = "상품가격은 필수입력입니다.")
	private int productPrice;
	private int imageId;
	
	public Product toProduct() {
		return Product.builder()
				.categoryId(categoryId)
				.productName(productName)
				.productPrice(productPrice)
				.imageId(imageId)
				.build();
	}
}
