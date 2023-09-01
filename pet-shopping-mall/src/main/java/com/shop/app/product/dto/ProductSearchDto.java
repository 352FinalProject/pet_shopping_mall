package com.shop.app.product.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProductSearchDto {
	private int productId;
	private int categoryId;
	private String productName;
	private int productPrice;
	private String imageRenamedFileName;
	private Timestamp createDate;
	// 별점
	// 리뷰 추가
	private int reviewCnt;
	private double reviewStarRate;
}
