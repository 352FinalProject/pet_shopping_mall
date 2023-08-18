package com.shop.app.pet.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.entity.Pet;

//import com.shop.app.pet.dto.PetUpdateDto;


@Mapper
public interface PetRepository {
	
    @Insert("INSERT INTO pet (pet_id, member_id, pet_name, pet_DofB, pet_kind, pet_breed, pet_adoption, pet_gender) " +
            "VALUES (seq_pet_id.nextval, #{memberId}, #{petName}, #{petDofB, jdbcType=DATE}, #{petKind}, #{petBreed}, #{petAdoption, jdbcType=DATE}, #{petGender})")
    int petCreate(PetCreateDto pet);

    
    @Select("select * from pet")
    List<Pet> findPetByAll(Pet pet);

    @Delete("DELETE FROM pet WHERE pet_id = 1")
    int petDelete(int petId);


//    @Select("SELECT * FROM pet WHERE pet_id = #{petId}")
//    Pet petDetail(int petId);


	

    
//    @Delete("DELETE FROM pet WHERE pet_id = #{petId}")
//    int petDelete(int petId);
//
//    @Select("SELECT COUNT(*) FROM pet WHERE pet_id = #{petId}")
//    int findPetById(int petId);
//

	





	


	
}