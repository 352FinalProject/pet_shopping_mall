package com.shop.app.order.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderAdminListDto {
	private Long orderId;
	private Date orderDate; // 주문 일시 (orderTbl)
	private String orderNo; // 주문 번호 (orderTbl)
	private String productName; // 주문 상품 (product)
	// 주문 상태
	// 0: 입금대기 / 1: 입금완료 / 2: 배송준비 / 3: 배송중 / 4: 배송완료 / 5: 주문취소 / 6: 환불 / 7:반품
	private int orderStatus;// 주문 상태 (orderTbl)
	// 0: 결제 미완료 / 1: 결제완료
	private int paymentState;// 결제 상태 (orderTbl)
	private String memberId;// 주문자(이름) (member)
	private int amount; // 실 결제금액	(orderTbl)
	private int deliveryFee; // 배송비 (orderTbl)
	// 0: 무통장입금(현금) 1:카드결제
	private int paymentMethod;// 결제방법 (payment)
}
