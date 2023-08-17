package com.shop.app.terms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.terms.entity.Terms;
import com.shop.app.terms.service.TermsService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/terms")
@Slf4j
public class TermsController {
	
	@Autowired
	private TermsService termsService;
	
	@GetMapping("/terms.do")
	public void termsList (Terms terms, Model model) {
		List<Terms> termss = termsService.findTermsAll(terms);
		
		model.addAttribute("termss", termss);
		
	}
	
   
}
