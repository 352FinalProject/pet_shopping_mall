package com.shop.app.notification.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.app.notification.entity.Notification;
import com.shop.app.notification.service.NotificationService;


@RequestMapping("/*")
@Controller
public class NotificationController {
	
	@Autowired
	NotificationService notificationService;
	
	/**
	 * 알림DB 조회 (대원)
	 */
	@GetMapping("/*")
	public void payment(@RequestParam String memberId, Model model) {
		List<Notification> notification = notificationService.findAllNotification(memberId);
        
        model.addAttribute("notification", notification);

	}
}
