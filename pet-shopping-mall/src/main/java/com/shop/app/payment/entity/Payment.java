package com.shop.app.payment.entity;

import java.sql.Date;
import java.time.LocalDateTime;

import com.shop.app.point.entity.Point;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
	private int paymentId;
	private int paymentMethod; // 1. 카카오페이 2. 신용카드로 수정하기
	private Date paymentDate;
	private int amount; // 주문자가 결제한 금액(배송비 포함)
	private int orderId; // 주문번호(주문테이블 참조)
}
