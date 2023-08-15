package com.shop.app.pet.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;

import com.shop.app.pet.dto.PetCreateDto;

@Mapper
public interface PetRepository {

    @Insert("INSERT INTO pet (pet_id, pet_member_id, pet_name, pet_DofB, pet_kind, pet_breed, pet_adoption, pet_gender) " +
            "VALUES (seq_pet_id.nextval, #{petMemberId}, #{petName}, #{petDofB, jdbcType=DATE}, #{petKind}, #{petBreed}, #{petAdoption, jdbcType=DATE}, #{petGender})")
    int petCreate(PetCreateDto pet);
}