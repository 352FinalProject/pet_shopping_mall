<<<<<<< HEAD:pet-shopping-mall/src/main/java/com/shop/app/admin/controller/adminController.java
//package com.shop.app.admin.controller;
//
//import java.util.List;
//
//import javax.validation.Valid;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.validation.annotation.Validated;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import com.shop.app.admin.service.AdminService;
//import com.shop.app.member.entity.Member;
//
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@Validated
//@RequestMapping("/admin")
//@Controller
//public class adminController {
//	
//	@Autowired
//	private AdminService adminService;
//	
//	@GetMapping("/admin.do")
//	public void admin() {
//		
//	}
//	
//	@GetMapping("/adminMemberList.do")
//	public void adminMemberList(@Valid Member member, Model model) {
//		
//		List<Member> members = adminService.findAllByMemberId(member.getMemberId());
//		model.addAttribute("members", members);
//	}
//}
=======
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

@Validated
@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/admin.do")
	public void admin() {
		
	}
	
	@GetMapping("/adminMemberList.do")
	public void adminMemberList(@Valid Member member, Model model) {
		
//		List<Member> members = adminService.findAllByMemberId(member.getMemberId());
//		model.addAttribute("members", members);
	}
	
	@GetMapping("/adminSubscribeList.do")
	public void adminMemberList() {
		
	}
	
	@GetMapping("/adminProductList.do")
	public void adminProductList() {
		
	}
	
	@GetMapping("/adminOrderList.do")
	public void adminOrderList() {
		
	}
	
	@GetMapping("/adminStatistics.do")
	public void adminStatistics() {
		
	}
	
}
>>>>>>> c33df414c5286ffa848788a7a5d0279fda07164d:pet-shopping-mall/src/main/java/com/shop/app/admin/controller/AdminController.java
