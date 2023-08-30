package com.shop.app.common.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.shop.app.order.service.OrderService;


@Component
public class OrderScheduler {
	
	@Autowired
	OrderService orderService;
	
	/**
	 * 구매 후, 일주일이 지나면 자동으로 orderStatus를 업데이트 하기 위해서 만듦
	 * 매일 정각에 시행 (0 0 0 * * ?)
	 * 매 1분 시행 (0 *_/1 * * * ?) _는 제거 후 사용
	 */
	@Scheduled(cron = "0 0 0 * * ?")
	public void updateOrderStatus() {
		int result = orderService.updateOrderStatusIfExpired();
	}
}
