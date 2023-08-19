package com.shop.app.pet.cotroller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.entity.PetDetails;
import com.shop.app.pet.service.PetService; // 패키지명 수정
import com.shop.app.servicecenter.inquiry.entity.Question;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class PetController {

	@Autowired
	private PetService petService;

	// 1. 펫 디테일 클래스 만들기. 2.펫에 빌더 추가하기. 3.펫 컨트롤러에 빌더 가져오기. 4.인서트 쿼리문 작성 레파지토리에(했고)

	@GetMapping("/petProfile.do")
	public void petProfile() {}
	
	@PostMapping("/petProfile.do") // 1. 이부분 .do 추가
	public String petCreate(@ModelAttribute @Valid PetCreateDto pet, RedirectAttributes redirectAttributes) {
	    // 펫 등록 db 저장
	    int result = petService.petCreate(pet);
	    
	    if (result > 0) {
	        // 펫 등록 로직 수행   	
	        redirectAttributes.addFlashAttribute("successMessage", "등록성공!");
	    }
	    
	    return "redirect:/member/petList.do"; // 등록 후 다시 폼으로 리다이렉트
	}

	@GetMapping("/petList.do")
	public void petList(Pet pet, Model model) {
		List<Pet> pets = petService.findPetByAll(pet); 
		model.addAttribute("pets", pets);
		}
	
	@GetMapping("/petDetail.do")
	public String petDetail(@RequestParam int petId, Model model) {
	    Pet pet = Pet.builder()
	            .petId(petId)
	            .build();

	    Pet petInfo = petService.findPetById(petId); // petId에 해당하는 펫 정보 가져오기
	    model.addAttribute("petInfo", petInfo); // 펫 정보를 모델에 추가

	    return "member/petDetail"; // petDetail.jsp로 이동
	}
	
	 @PostMapping("/petDelete.do")
	 public String petDelete(@RequestParam int petId) {
	    int result = petService.petDelete(petId);
	    return "redirect:/member/petList.do";
	    }

}





//	@PostMapping("/petUpdate")
//	public String petUpdate(@Valid PetUpdateDto pet, RedirectAttributes redirectAttributes) {
//	
//		int result = petService.petUpdate(pet); // PetService에서 업데이트 로직 수행
//
//	    if (result > 0) { // 업데이트 성공 여부 확인
//	        redirectAttributes.addFlashAttribute("successMessage", "수정완료!");
//	    }
//
//	    return "redirect:/member/petList.do"; // 목록 페이지로 리다이렉트
//	}

    
