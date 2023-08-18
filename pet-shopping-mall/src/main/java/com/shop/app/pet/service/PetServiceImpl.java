package com.shop.app.pet.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.repository.PetRepository;
import com.shop.app.servicecenter.inquiry.entity.Question;

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
	public int findPetById(int pet) {
	    return petRepository.petDelete(pet);
	}

    @Override
    public int petDelete(int petId) {
        return petRepository.petDelete(petId);
    }
    
    
	@Override
    public int petDetail(int petId) {
        return petRepository.petDetail(petId); 
    }
}




//    @Override
//    public int petUpdate(PetUpdateDto pet) {
//    return petRepository.petUpdate(pet);
//	}


