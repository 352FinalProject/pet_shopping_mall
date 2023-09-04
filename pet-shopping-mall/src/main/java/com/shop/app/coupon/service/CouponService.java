package com.shop.app.coupon.service;

import java.util.List;

import com.shop.app.coupon.dto.MemberCouponDto;
import com.shop.app.coupon.entity.Coupon;
import com.shop.app.coupon.entity.MemberCoupon;

public interface CouponService {

	List<Coupon> findCoupon();

	int insertDeliveryCoupon(MemberCoupon memberCoupon);
	
	List<MemberCouponDto> findCouponsByMemberId(String memberId);

	int findCouponById();

	List<MemberCoupon> findCouponCurrendById(MemberCoupon coupon);

	List<MemberCoupon> validateCoupon(int couponId, String memberId, Integer MemberCouponId);

	int updateCouponStatus(MemberCoupon validCoupon);

	int updateCoupon(MemberCoupon coupon);

	List<MemberCoupon> findUsedCouponsByMemberId(String memberId);

	List<MemberCouponDto> findCouponAll(String memberId);

}
