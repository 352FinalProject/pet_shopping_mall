package com.shop.app.coupon.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class MemberCoupon {
	
	private Integer memberCouponId;
	private int couponId; // coupon 테이블 coupon_id 참조
	private String memberId; // 쿠폰 사용한 멤버 아이디
	private LocalDateTime createDate; // 발급 날짜
	private LocalDateTime endDate; // 유효기간 (언제까지)
	private int useStatus; // 사용 여부 (사용 안 하면 0, 사용하면 1)
	private LocalDateTime useDate; // 사용 날짜 (사용 안 하면 null)

}