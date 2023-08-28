package com.shop.app.coupon.service;

import java.util.List;

import com.shop.app.coupon.dto.MemberCouponDto;
import com.shop.app.coupon.entity.Coupon;
import com.shop.app.coupon.entity.MemberCoupon;

public interface CouponService {

	// 배송비 무료 쿠폰 회원한테 넣어주기 위해서 쿠폰 db 조회 (예라)
	List<Coupon> findCoupon();

	// memberCoupon db 추가 (예라)
	int insertDeliveryCoupon(MemberCoupon memberCoupon);
	
	// 결제할 때 쿠폰 목록 보여주기 (예라)
	List<MemberCouponDto> findCouponsByMemberId(String memberId);

	// 멤버 쿠폰 아이디 조회 (예라)
	int findCouponById();

	// 쿠폰 조회(예라)
	List<MemberCoupon> findCouponCurrendById(MemberCoupon coupon);

	// 유효기간이 있는 쿠폰인지 확인 (예라)
	List<MemberCoupon> validateCoupon(int couponId, String memberId, Integer MemberCouponId);

	// 쿠폰 사용 (예라)
	int updateCouponStatus(MemberCoupon validCoupon);

	// 결제 안 하고 취소할 때 쿠폰 돌려주기 (예라)
	int updateCoupon(MemberCoupon coupon);

	// 결제 안 하고 취소할 때 쿠폰 돌려주기 (예라)
	List<MemberCoupon> findUsedCouponsByMemberId(String memberId);


}
