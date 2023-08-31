package com.shop.app.notification.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.app.member.entity.MemberDetails;
import com.shop.app.notification.entity.Notification;
import com.shop.app.notification.service.NotificationService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notification")
public class NotificationController {
	
	
	@Autowired
	private NotificationService notificationService;
	
	@ResponseBody
	@GetMapping("/findAllNotification.do")
	public void findAllNotification(@RequestParam String memberId, Model model) {
	    List<Notification> notifications = notificationService.findAllNotification(memberId);
	    model.addAttribute("notifications", notifications);
	}
	
	
	
	
	@ResponseBody
	@PostMapping("/deleteNotification.do")
	public void deleteNotification(@RequestParam int id) {
		try {
			notificationService.deleteNotification(id);
			System.out.println("삭제완료!!!!");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
