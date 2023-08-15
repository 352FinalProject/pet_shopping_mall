package com.shop.app.pet.service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.repository.PetRepository;

@Service
public interface PetService {

	int petCreate(PetCreateDto pet);

	List<Pet> findPetByAll(Pet pet);

	int findPetById(int petId);


}