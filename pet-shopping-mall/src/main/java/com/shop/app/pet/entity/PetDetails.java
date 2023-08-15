package com.shop.app.pet.entity;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.shop.app.pet.dto.PetCreateDto;

@Mapper
public interface PetDetails {

    @Insert("INSERT INTO pet (pet_id, pet_member_id, pet_name, pet_DofB, pet_kind, pet_breed, pet_adoption, pet_gender) " +
            "VALUES (#{petId}, #{petMemberId}, #{petName}, #{petDofB}, #{petKind}, #{petBreed}, #{petAdoption}, #{petGender})")
    int petCreate(PetCreateDto pet);
}