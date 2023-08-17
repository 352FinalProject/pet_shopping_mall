package com.shop.app.order.entity;

import java.sql.Timestamp;

public class CancelOrder {
	private int cancelId; // PK
	private Timestamp requestDate; // 취소 요청날짜
	private Timestamp receiptDate; // 취소 확정날짜 (관리자가 허락한)
	private int cancelStatus; // 0: 취소 요청 / 1: 취소 완료
	private int orderId; // 주문번호
}
