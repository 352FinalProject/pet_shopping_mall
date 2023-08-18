package com.shop.app.product.dto;

import javax.validation.constraints.NotNull;

import com.shop.app.product.entity.Product;

import lombok.Data;

@Data
public class ProductCreateDto {
	@NotNull(message = "상품카테고리는 필수입력입니다.")
	private int categoryId;
	@NotNull(message = "상품명은 필수입력입니다.")
	private String productName;
	@NotNull(message = "상품가격은 필수입력입니다.")
	private int productPrice;
	private int thumbnailImg;
	private int productImg;
	
	public Product toProduct() {
		return Product.builder()
				.categoryId(categoryId)
				.productName(productName)
				.productPrice(productPrice)
				.thumbnailImg(thumbnailImg)
				.productImg(productImg)
				.build();
	}
}
