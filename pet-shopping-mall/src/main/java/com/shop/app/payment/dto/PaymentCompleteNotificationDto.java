package com.shop.app.payment.dto;

import java.sql.Timestamp;

import com.shop.app.member.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PaymentCompleteNotificationDto {
	private int orderId;
	private String orderNo; // orderTbl
	private String productName; // product
	// 1: 결제완료 / 2: 배송준비 / 3: 배송중 / 4: 배송완료 / 5: 주문취소(환불) / 6: 구매확정
	private int orderStatus;
	private String memberId;
	
}
