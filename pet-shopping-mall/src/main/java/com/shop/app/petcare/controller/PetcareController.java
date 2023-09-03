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
	
//	@PostMapping("/reservation.do")
//	public String reservation(
//			@ModelAttribute
//			BindingResult bindingResult,
//			@Valid petReservationDto petReservation,
//			Pet pet,
//			Petcare petCare,
//			Principal principal, 
//			Model model) {
//		
//
//		int result = petCareService.insertReservation(petReservation);
//
//		return "redirect:/petcare/petcareList.do";
//		
//	}
	
//	@PostMapping("/reservation.do")
//	public String reservation(
//			@ModelAttribute
//			BindingResult bindingResult,
//			@Valid petReservationDto petReservation,
//			Pet pet,
//			Petcare petCare,
//			Principal principal, 
//			Model model) {
//		
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		String petcareMemberId = authentication.getName();
//		//int petcareId = petCare.getPetcareId();
//		int petcareCareType = petCare.getPetcareCareType();
//		
//		PetcareDetails petcareDetails = PetcareDetails.builder()
//				.petcareId(petcare.getPetcareId())
//				.petcareMemberId(petcareMemberId)
//				.petcarePetId(pet.getPetId())
//				.petcareCareType(petcareCareType)
//				.petAge(pet.getPetAge())
//				.petKind(pet.getPetKind())
//				.petBreed(pet.getPetBreed())
//				.petWeight(pet.getPetWeight())
//				.petGender(pet.getPetGender())
//				.petDofBFix(pet.getPetDofBFix())
//				.build();
//		
//		int petcareId = petCareService.insertReservation(petResrvation);
//		
//		return "redirect:/petcare/petcareList.do";
//		
//	}
	

}