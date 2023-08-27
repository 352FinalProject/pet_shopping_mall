package com.shop.app.payment.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SubScheduleDto {
	private String customerUid;
	private int amount;
	private String merchantUid;
}
