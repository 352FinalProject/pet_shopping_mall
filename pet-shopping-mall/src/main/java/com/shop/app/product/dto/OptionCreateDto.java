package com.shop.app.product.dto;

import javax.validation.constraints.NotNull;

import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductOption;

import lombok.Data;

@Data
public class OptionCreateDto {
	private int productId;
	private String optionName;
	private String optionValue;
	
	@NotNull(message = "상품카테고리는 필수입력입니다.")
	private int categoryId;
	@NotNull(message = "상품명은 필수입력입니다.")
	private String productName;
	@NotNull(message = "상품가격은 필수입력입니다.")
	private int productPrice;
	private int thumbnailImg;
	private int productImg;
	
	
	public ProductOption toProductOption() {
		return ProductOption.builder()
				.productId(productId)
				.optionName(optionName)
				.optionValue(optionValue)
				.build();
	}
	
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
