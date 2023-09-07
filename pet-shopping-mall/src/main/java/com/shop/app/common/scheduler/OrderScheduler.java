package com.shop.app.common.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.shop.app.notification.service.NotificationService;
import com.shop.app.member.service.MemberService;
import com.shop.app.order.service.OrderService;


@Component
public class OrderScheduler {
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	NotificationService notificationService;

	@Autowired
	MemberService memberService;
	
	/**
	 * @author 김담희
	 * 구매 후, 일주일이 지나면 자동으로 orderStatus를 업데이트 하기 위해서 만듦
	 * 매일 정각에 시행 (0 0 0 * * ?)
	 * 매 1분 시행 (0 *_/1 * * * ?) _는 제거 후 사용
	 * 
	 * @author 김대원
	 * 구매확정으로 데이터가 바뀌면 사용자 개인에게 알림을 보냄
	 */
	@Scheduled(cron = "0 0 0 * * ?")
	public void updateOrderStatus() {
		int result = orderService.updateOrderStatusIfExpired();
		int updateOrderStatusNotification = notificationService.updateOrderStatusNotification();
	}
	
	/**
	 * @author 김담희
	 * 구독 취소를 한 멤버를 찾아서, 다음달 결제 예정일이 되었는데 구독 취소 신청을 한 상태라면
	 * 멤버 테이블의 subscribe 컬럼을 N 로 바꿔서 일반 회원으로 내리기 위한 스케쥴러
	 */
	@Scheduled(cron = "0 0 0 * * ?")
	public void updateCancelSubscribers() {
		int result = memberService.updateCancelSubscribers();
	}
}
