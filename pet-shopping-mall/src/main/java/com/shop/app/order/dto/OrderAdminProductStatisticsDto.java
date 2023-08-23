package com.shop.app.order.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderAdminProductStatisticsDto {
	private int productId;
	private String productName; // 주문 상품 (product)
	private int categoryId;
	private String categoryName;
	private int productPrice;
	private int totalSold; // 총 판매수
	private int totalPrice; // 총 판매액
	
}
