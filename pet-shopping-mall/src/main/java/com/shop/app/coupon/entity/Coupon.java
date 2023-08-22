package com.shop.app.coupon.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class Coupon {
	
	private int couponId;
	private String couponName; // 쿠폰 이름 (ex. 배송비 무료 쿠폰 / 생일축하 쿠폰)
	private int discountAmount; // 할인 고정 금액 (ex. 3,000원 - 배송비 무료 쿠폰)
	private int discountPercentage; // 할인 비율 (ex. 10% - 생일 쿠폰)
}
