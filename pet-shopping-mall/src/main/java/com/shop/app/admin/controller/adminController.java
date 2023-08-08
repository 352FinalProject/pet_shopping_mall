package com.shop.app.admin.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.admin.service.AdminService;
import com.shop.app.member.entity.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Validated
@RequestMapping("/admin")
@Controller
public class adminController {
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/admin.do")
	public void admin() {
		
	}
	
	@GetMapping("/adminMemberList.do")
	public void adminMemberList(@Valid Member member, Model model) {
		
		List<Member> members = adminService.findAllByMemberId(member.getMemberId());
		model.addAttribute("members", members);
	}
}
