package com.shop.app.pet.cotroller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.dto.PetUpdateDto;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.service.PetService; // 패키지명 수정
import com.shop.app.servicecenter.inquiry.entity.Question;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/pet")
public class PetController {
	@Autowired
	private PetService petService;


	@GetMapping("/petProfile.do")
	
	public void petProfile() {}
	
	@PostMapping("/petProfile.do") 
	public String petCreate(@ModelAttribute @Valid PetCreateDto pet, RedirectAttributes redirectAttributes) {
	
	    int result = petService.petCreate(pet);
	    
	    if (result > 0) {

	        redirectAttributes.addFlashAttribute("successMessage", "등록성공!");
	    }
	    
	    return "redirect:/pet/petList.do"; 
	}

	@GetMapping("/petList.do")
	public String petList(Principal principal, Model model) {
	    String memberId = principal.getName(); 
	    List<Pet> pets = petService.findPetsByMemberId(memberId);
	    model.addAttribute("pets", pets);

	    return "pet/petList";
	}
	
	@GetMapping("/petDetail.do")
	public String petDetail(@RequestParam int petId, Model model) {
	    Pet pet = Pet.builder()
	            .petId(petId)
	            .build();

	    Pet petInfo = petService.findPetById(petId);
	    model.addAttribute("petInfo", petInfo);

	    return "pet/petDetail";
	}
	
	@GetMapping("/petGoDetail.do")
	public String petGoDetail(@RequestParam int petId, Model model) {
	    Pet pet = Pet.builder()
	            .petId(petId)
	            .build();

	    Pet petInfo = petService.findPetById(petId); // petId에 해당하는 펫 정보 가져오기
	    model.addAttribute("petInfo", petInfo); // 펫 정보를 모델에 추가

	    return "pet/petUpdate"; // petDetail.jsp로 이동
	}
	

	@PostMapping("/petDelete.do")
	public String petDelete(@Valid int petId, RedirectAttributes redirectAttributes) {		
		int cnt = petService.petDelete(petId);
		

	    return "redirect:/pet/petList.do";
    }
	
	@PostMapping("/petUpdate.do")
	public String petUpdate(@Valid PetUpdateDto pet, RedirectAttributes redirectAttributes) {
		int result = petService.petUpdate(pet); // PetService에서 업데이트 로직 수행

	
	    return "redirect:/pet/petList.do"; // 목록 페이지로 리다이렉트
	    
	    
	}

}







    