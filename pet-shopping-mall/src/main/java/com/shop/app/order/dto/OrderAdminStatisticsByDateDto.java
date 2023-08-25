package com.shop.app.order.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderAdminStatisticsByDateDto {
	private String orderMonthly;
	private String orderDaily;
	private int dailyTotalSales;
	private int monthlyTotalSales;
	
}
