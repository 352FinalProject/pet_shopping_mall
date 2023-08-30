package com.shop.app.notification.controller;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.app.notification.service.NotificationService;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/notification")
@Slf4j
public class NotificationController {
    
    @Autowired
    NotificationService notificationService;
    
    @PostMapping("/deleteNotification.do")
    public String deleteNotification(@RequestParam("id") String _id
    		) {
    	
    	int id = Integer.parseInt(_id);
    	
    	System.out.println("ㅋㅋㅋ");
    	log.debug("id = {}", id);
        try {
            notificationService.deleteNotification(id);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
}
