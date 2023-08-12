package com.shop.app.admin.controller;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.app.admin.service.AdminService;
import com.shop.app.member.entity.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Validated
@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/admin.do")
	public void admin() {}
	
	@GetMapping("/adminMemberList.do")
	public void adminMemberList(@RequestParam(defaultValue = "1") int page,
			Model model) {
		
		int limit = 10;
		Map<String, Object> params = Map.of(
				"page", page,
				"limit", limit
			);
		// MemberDetails로 바꿔야댐
		List<Member> members = adminService.adminMemberList(params);
		// log.debug("members = {}", members);
		model.addAttribute("members", members);
	}
	

	@GetMapping("/adminOrderList.do")
	public void adminOrderList() {}
	
	@GetMapping("/adminProductList.do")
	public void adminProductList() {}
	
	@GetMapping("/adminStatistics.do")
	public void adminStatistics() {}
	
	@GetMapping("/adminSubscribeList.do")
	public void adminSubscribeList() {}
	
	
}

