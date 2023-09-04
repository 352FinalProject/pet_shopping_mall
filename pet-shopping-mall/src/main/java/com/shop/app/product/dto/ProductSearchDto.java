package com.shop.app.product.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProductSearchDto {
	private int productId;
	private int categoryId;
	private String productName;
	private int productPrice;
	private String thumbnail;
	private Timestamp createDate;
	private int reviewCnt;
	private double reviewStarRate;
	private String categoryName;
}
