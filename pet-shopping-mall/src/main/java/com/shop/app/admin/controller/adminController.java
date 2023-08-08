package com.shop.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.extern.slf4j.Slf4j;

@Slf4j
@Validated
@RequestMapping("/admin")
@Controller
public class adminController {
	
	@GetMapping("/admin.do")
	public void admin() {
		
	}
	
	@GetMapping("/adminMemberList.do")
	public void adminMemberList() {
		
	}
}
