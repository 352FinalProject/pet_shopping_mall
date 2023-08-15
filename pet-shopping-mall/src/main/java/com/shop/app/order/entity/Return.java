package com.shop.app.order.entity;

import java.sql.Date;

public class Return {
	private int returnId;
	private int returnStatus; // 0: 반품 미완료 / 1: 반품완료
	private Date requestDate; // 반품 신청 날짜
	private Date receiptDate; // 반품 확정 날짜
	private Date withdrawDate; // 반품 취소 날짜
	private int orderId; // 주문번호
}
