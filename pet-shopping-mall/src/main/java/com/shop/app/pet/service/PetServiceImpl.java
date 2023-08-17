package com.shop.app.pet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.repository.PetRepository;

@Service
public class PetServiceImpl implements PetService {
	
	@Autowired
	private PetRepository petRepository;
	
	@Override
	public int petCreate(PetCreateDto pet) {
	return petRepository.petCreate(pet);
	}

	@Override
	public List<Pet> findPetByAll(Pet pet) {
		return petRepository.findPetByAll(pet);
	}

	@Override
	public int findPetById(int petId) {
		return petRepository.findPetById(petId);
	}
}
