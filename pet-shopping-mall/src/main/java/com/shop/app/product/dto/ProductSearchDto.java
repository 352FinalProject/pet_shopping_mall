package com.shop.app.product.dto;

import lombok.Data;

@Data
public class ProductSearchDto {
	private int productId;
	private int categoryId;
	private String productName;
	private int productPrice;
	private String imageRenamedFileName;
	private int reviewCnt;
	// 별점
	// 리뷰 추가
}
