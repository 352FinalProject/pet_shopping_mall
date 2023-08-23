package com.shop.app.pet.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.dto.PetUpdateDto;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.repository.PetRepository;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.service.QuestionServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PetServiceImpl implements PetService {
	
	@Autowired
	private PetRepository petRepository;

	@Override
	public int petCreate(PetCreateDto pet) {
	    return petRepository.petCreate(pet);
	}

//	@Override
//	public List<Pet> findPetByAll(Pet pet) {
//	    return petRepository.findPetByAll(pet);
//	}

    @Override
    public List<Pet> findPetsByMemberId(String memberId) {
        return petRepository.findPetsByMemberId(memberId);
    }
    
    @Override
    public int petDelete(int petId) {
        return petRepository.petDelete(petId);
    }

	@Override
	public Pet findPetById(int petId) {
	    return petRepository.findPetById(petId);
    }
	
	@Override
	public int petUpdate(PetUpdateDto pet) {
		return petRepository.petUpdate(pet);
	}

	// 리뷰-펫 정보 가져오기(혜령)
	@Override
	public List<Pet> findPetId(Pet pet, String memberId) {
		return petRepository.findPetId(pet, memberId);
	}

	// 상품 상세페이지 - 리뷰 - 펫 정보 가져오기 (혜령) 
	@Override
	public List<Pet> findProductRevicePet(String memberId) {
		return petRepository.findProductRevicePet(memberId);
	}

	@Override
	public List<Pet> findReviewPetByMemberId(String reviewMemberId) {
		return petRepository.findReviewPetByMemberId(reviewMemberId);
	}

}