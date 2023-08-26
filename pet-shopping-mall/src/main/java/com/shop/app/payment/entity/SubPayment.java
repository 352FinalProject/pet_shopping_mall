package com.shop.app.payment.entity;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SubPayment {
	private int subPaymentId;
	private String memberId;
	private Timestamp paymentDate;
}
