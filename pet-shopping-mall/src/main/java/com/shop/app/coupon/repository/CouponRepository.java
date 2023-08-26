package com.shop.app.coupon.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.shop.app.coupon.dto.MemberCouponDto;
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

	@Select("select * from member_coupon m left join coupon c on m.coupon_id = c.coupon_id where m.member_id = #{memberId}")
	List<MemberCouponDto> findCouponsByMemberId(String memberId);

	// 멤버 쿠폰 아이디 조회 (예라)
	@Select("select * from member_coupon where coupon_id = #{couponId}")
	int findCouponById();

	// 멤버 쿠폰 조회 (예라)
	@Select("select * from member_coupon where coupon_id = #{couponId}")
	MemberCoupon findCouponCurrendById(MemberCoupon coupon);

	// 유효기간이 있는 쿠폰인지 확인 (예라)
	@Select("select * from member_coupon where coupon_id = #{couponId} and member_id = #{memberId} and end_date >= current_timestamp and use_status = 0")
	MemberCoupon validateCoupon(int couponId, String memberId);

	// 쿠폰 사용 (예라)
	int updateCouponStatus(MemberCoupon validCoupon); 

}
