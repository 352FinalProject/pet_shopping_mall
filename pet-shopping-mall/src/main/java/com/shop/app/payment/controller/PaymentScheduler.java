package com.shop.app.payment.controller;

import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.support.PeriodicTrigger;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.service.MemberService;
import com.shop.app.payment.dto.SubScheduleDto;
import com.shop.app.payment.service.PaymentService;
import com.shop.app.payment.service.SchedulePay;

import lombok.extern.slf4j.Slf4j;

/**
 * 정기 결제 (구독자)를 위한 스케쥴러
 */
@Component
@Slf4j
public class PaymentScheduler {

	private ThreadPoolTaskScheduler scheduler;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	PaymentService paymentService;
	
	@Autowired
	SchedulePay schedulePay;

	// 구독 취소 시 scheduler shutdown을 통해 결제 요청 멈춤
	public void stopScheduler(@AuthenticationPrincipal MemberDetails member) {
		scheduler.shutdown();
		// 멤버롤 다시 바꿔주기
		String memberId = member.getMemberId();
		int result = memberService.subscribeCancel(memberId);
	}
	
	
	public void startScheduler(String merchantUid, String customerUid, int amount) {
		scheduler = new ThreadPoolTaskScheduler();
		scheduler.initialize();
		scheduler.schedule(getRunnable(merchantUid, customerUid, amount), getTrigger());
	}
	
	
	
	private Runnable getRunnable(String merchantUid, String customerUid, int amount){
    	Date date = new Date();
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);
    	cal.add(Calendar.MONTH, 1);
    	cal.add(Calendar.DATE, 1);
    	
        return () -> {
        	schedulePay.schedulePay(merchantUid, customerUid, amount);
        	paymentService.insertSubPayment(customerUid);
        };
    }
	
	
	
	// 한 달마다 결제
    private Trigger getTrigger() {
        return new PeriodicTrigger(30, TimeUnit.DAYS);
    }

}
