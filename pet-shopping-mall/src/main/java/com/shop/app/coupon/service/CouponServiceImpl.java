package com.shop.app.coupon.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.shop.app.coupon.dto.MemberCouponDto;
import com.shop.app.coupon.entity.Coupon;
import com.shop.app.coupon.entity.MemberCoupon;
import com.shop.app.coupon.repository.CouponRepository;
import com.shop.app.member.entity.Member;
import com.shop.app.member.repository.MemberRepository;
import com.shop.app.notification.entity.Notification;
import com.shop.app.notification.repository.NotificationRepository;

@Service
public class CouponServiceImpl implements CouponService {

	@Autowired
	private CouponRepository couponRepository;
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	NotificationRepository notificationRepository;
	
	@Autowired
	SimpMessagingTemplate simpMessagingTemplate;

	@Override
	public List<Coupon> findCoupon() {
		return couponRepository.findCoupon();
	}

	@Override
	public int insertDeliveryCoupon(MemberCoupon memberCoupon) {
		return couponRepository.insertDeliveryCoupon(memberCoupon);
	}
	
	/**
	 * @author 전예라
	 * 매달 생일자에게 유효기간이 한 달인 생일쿠폰을 발급한다
	 *
	 * @author 김대원
	 * 생일 쿠폰이 발급되면 생일자에게 알림을 보낸다
	 */
	@Scheduled(cron = "0 08 16 * * ?")
	public void issueBirthdayCoupons() {
	    
	    // 오늘 날짜 (매월 1일)
	    LocalDate today = LocalDate.now();
	    int currentMonth = today.getMonthValue();
	    
	    List<Member> thisMonthBirthdayMembers = memberRepository.findThisMonthBirthdayMembers(currentMonth);
	    
	    for (Member member : thisMonthBirthdayMembers) {
	        
	        MemberCoupon memberCoupon = new MemberCoupon();
	        memberCoupon.setMemberId(member.getMemberId());
	        memberCoupon.setCouponId(2);
	        
	        memberCoupon.setCreateDate(LocalDateTime.of(today.getYear(), currentMonth, 1, 0, 0));
	        memberCoupon.setEndDate(memberCoupon.getCreateDate().plusMonths(1));
	        memberCoupon.setUseStatus(0);
	        
	        int result = couponRepository.insertDeliveryCoupon(memberCoupon);
	        
 			String to = memberCoupon.getMemberId();
 			Notification insertNotification = Notification.builder()
 					.notiCategory(3)
 					.notiContent("생일자 할인쿠폰(10%)이 발급됐습니다.")
 					.notiCreatedAt(formatTimestampNow())
 					.memberId(to) 
 					.build();
 
 			notificationRepository.insertNotification(insertNotification);
 			Notification notification = notificationRepository.latestNotification();
 			simpMessagingTemplate.convertAndSend("/pet/notice/" + to, notification);
	        
	    }
	}

	public List<MemberCouponDto> findCouponsByMemberId(String memberId) {
		return couponRepository.findCouponsByMemberId(memberId);
	}

	@Override
	public int findCouponById() {
		return couponRepository.findCouponById();
	}

	@Override
	public List<MemberCoupon> findCouponCurrendById(MemberCoupon coupon) {
		return couponRepository.findCouponCurrendById(coupon);
	}

	@Override
	public List<MemberCoupon> validateCoupon(int couponId, String memberId, Integer memberCouponId) {
		return couponRepository.validateCoupon(couponId, memberId, memberCouponId);
	}

	@Override
	public int updateCouponStatus(MemberCoupon validCoupon) {
		return couponRepository.updateCouponStatus(validCoupon);
	}

	@Override
	public int updateCoupon(MemberCoupon coupon) {
		return couponRepository.updateCoupon(coupon);
	}

	@Override
	public List<MemberCoupon> findUsedCouponsByMemberId(String memberId) {
		return couponRepository.findUsedCouponsByMemberId(memberId);
	}
	

	@Override
	public List<MemberCouponDto> findCouponAll(String memberId) {
		return couponRepository.findCouponAll(memberId);
	}
	
	private String formatTimestamp(Timestamp timestamp) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yy/MM/dd HH:mm:ss");
        return dateFormat.format(timestamp);
    }
    private String formatTimestampNow() {
        return formatTimestamp(new Timestamp(System.currentTimeMillis()));
    }

}
