package com.shop.app.petcare.controller;

import java.security.Principal;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.entity.PetGender;
import com.shop.app.petcare.dto.petcareDto;
import com.shop.app.petcare.dto.petReservationDto;
import com.shop.app.petcare.entity.Petcare;
import com.shop.app.petcare.entity.PetcareDetails;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 혜령
 * - 병원예약(펫케어)
 */
@Controller
@Slf4j
@RequestMapping("/petcare")
public class PetcareController {

//	@Autowired
//	private PetcareService petCareService;
	
	@GetMapping("/petcareList.do")
	public void petcareList() {}
	
	@GetMapping("/reservation.do")
	public void reservation() {
		
	}
	
}