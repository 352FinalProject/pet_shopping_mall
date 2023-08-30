package com.shop.app.notification.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
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
    
    @ResponseBody
    @PostMapping("/deleteNotification.do")
    public String deleteNotification(@RequestParam int id) {
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
