package com.shop.app.pet.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.repository.PetRepository;

@Service
public class PetServiceImpl implements PetService {
	
	@Autowired
	private PetRepository petRepository;
	
	@Override
	public int petCreate(PetCreateDto pet) {
	return petRepository.petCreate(pet);
	}

}