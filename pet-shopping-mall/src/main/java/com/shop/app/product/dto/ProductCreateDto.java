package com.shop.app.product.dto;

import javax.validation.constraints.NotNull;

import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;

import lombok.Data;

@Data
public class ProductCreateDto {
	@NotNull(message = "상품카테고리는 필수입력입니다.")
	private ProductCategory productCategory;
	@NotNull(message = "상품명은 필수입력입니다.")
	private String ProductName;
	@NotNull(message = "상품가격은 필수입력입니다.")
	private int productPrice;
	
	public Product toProduct() {
		return Product.builder()
				.productCategory(productCategory)
				.ProductName(ProductName)
				.productPrice(productPrice)
				.build();
	}
}
