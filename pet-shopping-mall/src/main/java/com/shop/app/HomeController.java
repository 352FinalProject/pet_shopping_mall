package com.shop.app;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.app.notification.entity.Notification;
import com.shop.app.notification.service.NotificationService;

import lombok.extern.slf4j.Slf4j;


@Controller
public class HomeController {
	
	@GetMapping("")
//	@ResponseBody // 응답메세지에 리턴객체 출력
	public String home() {
		return "forward:/index.jsp"; // forward:접두사를 사용하면, /WEB-INF/views/...jsp 경로가 아닌 주어진 경로 view단 연결
	}
	
}
