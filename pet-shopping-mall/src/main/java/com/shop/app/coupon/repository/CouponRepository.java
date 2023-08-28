package com.shop.app.coupon.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.coupon.dto.MemberCouponDto;
import com.shop.app.coupon.entity.Coupon;
import com.shop.app.coupon.entity.MemberCoupon;

@Mapper
public interface CouponRepository {

	// 배송비 무료 쿠폰 회원한테 넣어주기 위해서 쿠폰 db 조회 (예라)
	@Select("select * from coupon where coupon_id = '1'")
	List<Coupon> findCoupon();

	// memberCoupon db 추가 (예라)
	@Insert("insert into member_coupon (member_coupon_id, coupon_id, member_id, create_date, end_date, use_date) values (seq_member_coupon_id.nextval, #{couponId}, #{memberId}, default, #{endDate}, #{useDate, jdbcType=DATE} )")
	int insertDeliveryCoupon(MemberCoupon memberCoupon);

	// 결제할 때 쿠폰 목록 보여주기 (예라)
	@Select("select * from member_coupon m left join coupon c on m.coupon_id = c.coupon_id where m.member_id = #{memberId} and m.use_status = 0")
	List<MemberCouponDto> findCouponsByMemberId(String memberId);

	// 멤버 쿠폰 아이디 조회 (예라)
	@Select("select * from member_coupon where coupon_id = #{couponId}")
	int findCouponById();

	// 멤버 쿠폰 조회 (예라)
	@Select("select * from member_coupon where coupon_id = #{couponId}")
	List<MemberCoupon> findCouponCurrendById(MemberCoupon coupon);

	// 유효기간이 있는 쿠폰인지 확인 (예라)
	@Select("select * from member_coupon where coupon_id = #{couponId} and member_id = #{memberId} and end_date >= current_timestamp and use_status = 0")
	List<MemberCoupon> validateCoupon(int couponId, String memberId, Integer memberCouponId);

	// 쿠폰 사용 (예라)
	@Update("update member_coupon set use_status = #{useStatus}, use_date = current_timestamp where coupon_id = #{couponId} and member_id = #{memberId}")
	int updateCouponStatus(MemberCoupon validCoupon);

	// 결제 안 하고 취소할 때 쿠폰 돌려주기 (예라)
    @Update("update member_coupon set use_status = 0, use_date = null where coupon_id = #{couponId}")
    int updateCoupon(MemberCoupon coupon);

	// 결제 안 하고 취소할 때 쿠폰 돌려주기 (예라)
    @Select("select * from member_coupon where member_id = #{memberId} and use_status = 1")
	List<MemberCoupon> findUsedCouponsByMemberId(String memberId);
}
