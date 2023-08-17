package com.shop.app.order.entity;

import java.sql.Date;

public class Refund {
	private int refundId; // 환불 아이디
	private int orderId; // 주문번호
	private Date receiptDate; // 환불 접수 날짜
	private Date completeDate;
	private int refundStatus; // 0: 미완료 / 1: 완료
	private int refundMethod; // 0: 현금 / 1: 카드
	
	// 현금일 경우 채워지는 컬럼
	private String refundAccount; // 환불계좌
	private String accountName; // 예금주 이름
	private String bank; // 환불 은행
}
