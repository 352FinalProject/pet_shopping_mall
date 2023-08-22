package com.shop.app.coupon.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.coupon.entity.Coupon;
import com.shop.app.coupon.entity.MemberCoupon;

@Mapper
public interface CouponRepository {

	// 배송비 무료 쿠폰 회원한테 넣어주기 위해서 쿠폰 db 조회 (예라)
	@Select("select * from coupon where coupon_id = '1'")
	List<Coupon> findCoupon();

	// memberCoupon db 추가
	@Insert("insert into member_coupon (member_coupon_id, coupon_id, member_id, create_date, end_date, use_date) values (seq_member_coupon_id.nextval, #{couponId}, #{memberId}, default, #{endDate}, #{useDate, jdbcType=DATE} )")
	int insertDeliveryCoupon(MemberCoupon memberCoupon); 

}
