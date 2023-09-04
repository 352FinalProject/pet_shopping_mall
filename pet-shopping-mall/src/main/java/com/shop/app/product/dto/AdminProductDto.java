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
	private int productId; 
	private int categoryId; 
	private String productName; 
	private int productPrice; 
	private String thumbnail; 
	private String categoryName; 
	private List<ProductDetail> productOptions;
}
