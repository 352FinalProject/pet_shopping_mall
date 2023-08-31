package com.shop.app.notification.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.app.notification.service.NotificationService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notification")
public class NotificationController {

	@Autowired
	private NotificationService notificationService;

	@PostMapping("/deleteNotification.do")
	public String deleteNotification(@RequestParam String id) {
		System.out.println("컨트롤러에 매핑됨");

		int _id = Integer.parseInt(id);
		log.debug("id ={}", id);
		
		try {
			notificationService.deleteNotification(_id);
			return "success";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
}
