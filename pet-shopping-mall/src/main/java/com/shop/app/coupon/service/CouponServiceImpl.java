package com.shop.app.coupon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.coupon.entity.Coupon;
import com.shop.app.coupon.entity.MemberCoupon;
import com.shop.app.coupon.repository.CouponRepository;

@Service
public class CouponServiceImpl implements CouponService {

	@Autowired
	private CouponRepository couponRepository;

	// 배송비 무료 쿠폰 회원한테 넣어주기 위해서 쿠폰 db 조회 (예라)
	@Override
	public List<Coupon> findCoupon() {
		return couponRepository.findCoupon();
	}

	// memberCoupon db 추가
	@Override
	public int insertDeliveryCoupon(MemberCoupon memberCoupon) {
		return couponRepository.insertDeliveryCoupon(memberCoupon);
	}
	


}
