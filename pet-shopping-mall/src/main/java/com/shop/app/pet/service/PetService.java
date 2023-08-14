package com.shop.app.pet.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.app.pet.dto.PetDto;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.repository.PetRepository;

@Service
public class PetService {

    @Autowired
    private PetRepository petRepository;

    public void registerPet(PetDto petDto) {
        Pet pet = new Pet();
        pet.setName(petDto.getName());
        pet.setBirthday(petDto.getBirthday());
        pet.setType(petDto.getType());
        pet.setBreed(petDto.getBreed());
        pet.setAdoptionDate(petDto.getAdoptionDate());
        pet.setGender(petDto.getGender());

        petRepository.save(pet);
    }
}