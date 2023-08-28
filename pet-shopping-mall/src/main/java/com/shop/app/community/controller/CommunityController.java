package com.shop.app.community.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.community.dto.CommunityCreateDto;
import com.shop.app.community.entity.CommunityDetails;
import com.shop.app.community.service.CommunityService;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 혜령
 * - 커뮤니티(펫스토리) 
 */
@Controller
@Slf4j
@RequestMapping("/community")
public class CommunityController {

	@Autowired
	private CommunityService communityService;
	
	@GetMapping("/communityList.do")
	public void commnityList() {}
	
	// 커뮤니티 글쓰기 불러오기
	@GetMapping("/communityCreate.do")
	public void communityCreate() {
		
	}
	
//	@PostMapping("/communityCreate.do")
//	public String communityCreate(
//			@Valid CommunityCreateDto _community,
//			BindingResult bindingResult,
//			Model model) {
//		
//		CommunityDetails communities = CommunityDetails.builder()
//				.communityId(_community.getCommunityId())
//				.communityTitle(_community.getCommunityTitle())
//				.communityContent(_community.getCommunityContent())
//				.communityCreatedAt(_community.getCommunityCreatedAt())
//				.build();
//		
//		int result = communityService.insertCommunity(communities);
//		
//		return "redirect:/community/communityCreate.do";
//	}
}
