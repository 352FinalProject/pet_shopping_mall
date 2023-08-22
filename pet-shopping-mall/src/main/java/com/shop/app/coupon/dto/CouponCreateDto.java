package com.shop.app.coupon.dto;

import java.time.LocalDateTime;

import com.shop.app.coupon.entity.MemberCoupon;

import lombok.Data;

@Data
public class CouponCreateDto {
	
	private int couponId; // coupon 테이블 coupon_id 참조
	private String memberId; // 쿠폰 사용한 멤버 아이디
	private LocalDateTime endDate; // 유효기간 (언제까지)
	
	public MemberCoupon toMemberCoupon() {
		return MemberCoupon.builder()
				.couponId(couponId)
				.memberId(memberId)
				.endDate(endDate)
				.build();
	}
	
}
