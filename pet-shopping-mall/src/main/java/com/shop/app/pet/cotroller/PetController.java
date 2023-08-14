package com.shop.app.pet.cotroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.pet.dto.PetDto;
import com.shop.app.pet.service.PetService; // 패키지명 수정

@Controller
@RequestMapping("/pet")
public class PetController {


    @GetMapping("/register")
    public String showPetRegistrationForm(Model model) {
        model.addAttribute("petDto", new PetDto()); // 객체 생성 부분 수정
        return "pet_registration_form"; // 펫 등록 폼의 뷰 이름
    }

    @PostMapping("/register")
    public String registerPet(@ModelAttribute("petDto") PetDto petDto) {
        // 펫 등록 로직 수행
        petService.registerPet(petDto);

        return "redirect:/pet/register"; // 등록 후 다시 폼으로 리다이렉트
    }
}
