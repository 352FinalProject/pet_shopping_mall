package com.shop.app.petcare.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.petcare.dto.PetcareDto;
import com.shop.app.petcare.entity.PetcareDetails;
import com.shop.app.petcare.service.PetcareService;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 혜령
 * - 병원예약(펫케어)
 */
@Controller
@Slf4j
@RequestMapping("/petcare")
public class PetcareController {

	@Autowired
	private PetcareService PetcareService;
	
	@GetMapping("/petcareList.do")
	public void petcareList() {}
	
	@GetMapping("/reservation.do")
	public void reservation() {
		
	}
	
//	@PostMapping("/reservation.do")
//	public String reservation() {
//		
//	}
//	

}