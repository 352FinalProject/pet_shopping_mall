package com.shop.app.pet.service;

import java.util.List;
import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.dto.PetUpdateDto;
import com.shop.app.pet.entity.Pet;

public interface PetService {
    int petCreate(PetCreateDto petCreateDto);
    
    int petUpdate(PetUpdateDto petUpdateDto);

	List<Pet> findPetByAll(Pet pet);

	Pet findPetById(int petId);

	int petDelete(int petId);

	// 펫 정보 가져오기(혜령)
	Pet findPetId(Pet pet);
}