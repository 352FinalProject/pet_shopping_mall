package com.shop.app.pet.cotroller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.service.PetService; // 패키지명 수정

@Controller
@RequestMapping("/member")
public class PetController {

	@Autowired
	private PetService petService;

	// 1. 펫 디테일 클래스 만들기. 2.펫에 빌더 추가하기. 3.펫 컨트롤러에 빌더 가져오기. 4.인서트 쿼리문 작성 레파지토리에

    @PostMapping("/petProfile")
    public String petCreate(@Valid PetCreateDto pet) {
        // 펫 등록 로직 수행
    	
    	
    	// 펫 등록 db 저장
        int result = petService.petCreate(pet);
        
        return "redirect:/member/petList.do"; // 등록 후 다시 폼으로 리다이렉트
    }
}
