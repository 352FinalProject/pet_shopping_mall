package com.shop.app.order.dto;

import java.sql.Timestamp;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class OrderHistoryDto {
	private int orderId;
	private Timestamp orderDate; // orderTbl
	private String orderNo; // orderTbl
	private String productName; // product
	private String optionName; // product_detail
	private String optionValue; // product_detail
	private String quantity; // order_detail
	private int amount; // orderTbl
	private int productId; // 상품 아이디 (예라)
	
	// 1: 결제완료 / 2: 배송준비 / 3: 배송중 / 4: 배송완료 / 5: 주문취소(환불) / 6: 구매확정
	private int orderStatus;
	
	private int productId;
	
	private String imageOriginalFileName; // 이미지 파일 불러오기
	private String imageRenamedFileName;
	
}
