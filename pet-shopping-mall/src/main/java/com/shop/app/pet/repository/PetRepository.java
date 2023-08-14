package com.shop.app.pet.repository;


import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.shop.app.pet.dto.PetCreateDto;

@Mapper
public interface PetRepository {

	@Insert("")
	int petCreate(PetCreateDto pet);
   
}