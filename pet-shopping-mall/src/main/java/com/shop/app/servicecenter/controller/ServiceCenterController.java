package com.shop.app.servicecenter.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/servicecenter")
@Controller
public class ServiceCenterController {

	@GetMapping("/service.do")
	public void serviceCenter() {
		
	}
	
	@GetMapping("/questionList.do")
	public void questionList() {
	}
	
	@GetMapping("/questionCreate.do")
	public void questionCreate() {
		
	}
	
}
