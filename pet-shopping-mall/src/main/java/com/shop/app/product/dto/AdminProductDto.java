package com.shop.app.product.dto;

import java.sql.Timestamp;
import java.util.List;

import com.shop.app.product.entity.ProductDetail;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class AdminProductDto {
	private int productId; // product
	private int categoryId; // 카테고리
	private String productName; // 프로덕트
	private int productPrice; // 프로덕트
	private String thumbnail; // 이미지 / 이미지매핑테이블 두개 쪼인
	private String categoryName; // 카테고리
	private List<ProductDetail> productOptions;
}
