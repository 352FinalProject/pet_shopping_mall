package com.shop.app.coupon.dto;

import java.time.LocalDateTime;

import com.shop.app.coupon.entity.MemberCoupon;

import lombok.Data;

@Data
public class CouponCreateDto {
	
	private int couponId;
	private String memberId;
	private LocalDateTime endDate; 
	
	public MemberCoupon toMemberCoupon() {
		return MemberCoupon.builder()
				.couponId(couponId)
				.memberId(memberId)
				.endDate(endDate)
				.build();
	}
	
}
