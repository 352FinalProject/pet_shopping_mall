package com.shop.app.pet.cotroller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.service.PetService; // 패키지명 수정

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
	        redirectAttributes.addFlashAttribute("successMessage", "펫이 성공적으로 등록되었습니다.");
	    }
	    
	    return "redirect:/member/petList.do"; // 등록 후 다시 폼으로 리다이렉트
	}
}