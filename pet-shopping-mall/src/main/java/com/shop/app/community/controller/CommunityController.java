package com.shop.app.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.community.service.CommunityService;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author 혜령
 * - 커뮤니티(펫스토리) 
 *
 */
@Controller
@Slf4j
@RequestMapping("/community")
public class CommunityController {

//	@Autowired
//	private CommunityService communityService;
	
	@GetMapping("/communityList.do")
	public void commnityList() {}
	
	
}
