package com.shop.app.pet.service;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.repository.PetRepository;

@Service
public interface PetService {

	int petCreate(PetCreateDto pet);


}