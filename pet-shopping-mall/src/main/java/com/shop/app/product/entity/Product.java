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
	@NotNull
	private ProductCategory productCategory;
	@NotNull
	private String ProductName;
	@NotNull
	private int productPrice;
	
	private Timestamp expireDate;
	private Timestamp createdAt;
	
	private int likeCnt;
	private int viewCnt;
	
}
