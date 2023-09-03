package com.shop.app.product.dto;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ProductSearchKeywordDto {
	private String searchKeyword;
	private String searchCategory;
	
}
