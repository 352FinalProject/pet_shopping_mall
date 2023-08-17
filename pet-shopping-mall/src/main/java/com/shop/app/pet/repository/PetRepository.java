package com.shop.app.pet.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;

import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.entity.Pet;

@Mapper
public interface PetRepository {

    @Insert("INSERT INTO pet (pet_id, pet_member_id, pet_name, pet_DofB, pet_kind, pet_breed, pet_adoption, pet_gender) " +
            "VALUES (seq_pet_id.nextval, #{petMemberId}, #{petName}, #{petDofB, jdbcType=DATE}, #{petKind}, #{petBreed}, #{petAdoption, jdbcType=DATE}, #{petGender})")
    int petCreate(PetCreateDto pet);

    @Select("select * from pet")
	List<Pet> findPetByAll(Pet pet);

    @Delete("delete from pet where pet_id = 1")
	int findPetById(int petId);
}