package com.shop.app.product.entity;

import java.sql.Timestamp;

import javax.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Product {
	@NotNull
	private int productId;
	@NotNull(message = "상품카테고리는 필수입력입니다.")
	private ProductCategory productCategory;
	@NotNull(message = "상품명은 필수입력입니다.")
	private String ProductName;
	@NotNull(message = "상품가격은 필수입력입니다.")
	private int productPrice;
	
	private Timestamp expireDate;
	private Timestamp createdAt;
	
	private int likeCnt;
	private int viewCnt;
	
}
