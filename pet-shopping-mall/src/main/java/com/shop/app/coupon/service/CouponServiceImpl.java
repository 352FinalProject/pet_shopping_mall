package com.shop.app.coupon.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.shop.app.coupon.dto.MemberCouponDto;
import com.shop.app.coupon.entity.Coupon;
import com.shop.app.coupon.entity.MemberCoupon;
import com.shop.app.coupon.repository.CouponRepository;
import com.shop.app.member.entity.Member;
import com.shop.app.member.repository.MemberRepository;

@Service
public class CouponServiceImpl implements CouponService {

	@Autowired
	private CouponRepository couponRepository;
	
	@Autowired
	private MemberRepository memberRepository;

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
	
	@Scheduled(cron = "0 31 22 * * ?")  // 매월 1일 자정에 실행
	public void issueBirthdayCoupons() {
	    
	    // 오늘 날짜 (매월 1일)
	    LocalDate today = LocalDate.now();
	    int currentMonth = today.getMonthValue();
	    
	    // 1. 쿠폰 지급을 위해 이번 달에 생일인 회원을 찾는다.
	    List<Member> thisMonthBirthdayMembers = memberRepository.findThisMonthBirthdayMembers(currentMonth);
	    
	    for (Member member : thisMonthBirthdayMembers) {
	        
	        // 쿠폰 발급
	        MemberCoupon memberCoupon = new MemberCoupon();
	        memberCoupon.setMemberId(member.getMemberId());
	        memberCoupon.setCouponId(2);  // 생일 쿠폰 id
	        
	        // 이번 달 1일을 기준으로 쿠폰 발급
	        memberCoupon.setCreateDate(LocalDateTime.of(today.getYear(), currentMonth, 1, 0, 0));
	        memberCoupon.setEndDate(memberCoupon.getCreateDate().plusMonths(1));  // 유효기간 1개월
	        memberCoupon.setUseStatus(0);  // 사용 안함
	        
	        int result = couponRepository.insertDeliveryCoupon(memberCoupon);
	    }
	}

	// 결제할 때 쿠폰 목록 보여주기 (예라)
	public List<MemberCouponDto> findCouponsByMemberId(String memberId) {
		return couponRepository.findCouponsByMemberId(memberId);
	}

	// 멤버 쿠폰 아이디 조회 (예라)
	@Override
	public int findCouponById() {
		return couponRepository.findCouponById();
	}

	// 쿠폰 조회 (예라)
	@Override
	public List<MemberCoupon> findCouponCurrendById(MemberCoupon coupon) {
		return couponRepository.findCouponCurrendById(coupon);
	}

	// 유효기간이 있는 쿠폰인지 확인 (예라)
	@Override
	public List<MemberCoupon> validateCoupon(int couponId, String memberId, Integer memberCouponId) {
		return couponRepository.validateCoupon(couponId, memberId, memberCouponId);
	}

	// 쿠폰 사용 (예라)
	@Override
	public int updateCouponStatus(MemberCoupon validCoupon) {
		return couponRepository.updateCouponStatus(validCoupon);
	}


}
