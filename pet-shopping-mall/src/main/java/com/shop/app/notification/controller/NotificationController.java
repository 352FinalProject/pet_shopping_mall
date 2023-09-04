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
	
	/**
    * @author 김대원
    * 뷰 헤더에 알림내역 조회 메서드
    */
	@ResponseBody
	@GetMapping("/findAllNotification.do")
	public List<Notification> findAllNotification(@RequestParam String memberId, Model model) {
	    List<Notification> notifications = notificationService.findAllNotification(memberId);
	    model.addAttribute("notifications", notifications);
	    return notifications;
	}
	
	/**
    * @author 김대원
    * 알림확인 후 알림삭제 메서드
    */
	@ResponseBody
	@PostMapping("/deleteNotification.do")
	public String deleteNotification(@RequestParam int id) {
		System.out.println("id = " + id);
		int result = notificationService.deleteNotification(id);
		if (result == 1) {
			return "delete 성공";
		}else {
			return "delete 오류";
		}
		
	}
}
