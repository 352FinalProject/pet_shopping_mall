package com.shop.app.pet.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.shop.app.pet.dto.PetCreateDto;
import com.shop.app.pet.dto.PetUpdateDto;
import com.shop.app.pet.entity.Pet;

//import com.shop.app.pet.dto.PetUpdateDto;


@Mapper
public interface PetRepository {

	@Insert("INSERT INTO pet (pet_id, member_id, pet_name, pet_DofB, pet_kind, pet_breed, pet_weight, pet_adoption, pet_gender) " +
	        "VALUES (seq_pet_id.nextval, #{memberId}, #{petName}, #{petDofB, jdbcType=DATE}, #{petKind}, #{petBreed}, #{petWeight}, #{petAdoption, jdbcType=DATE}, #{petGender})")
	int petCreate(PetCreateDto pet);
	
    
//    @Select("select * from pet")
//    List<Pet> findPetByAll(Pet pet);
    
	   @Select("SELECT * FROM pet WHERE member_id = #{memberId}")
	    List<Pet> findPetsByMemberId(String memberId);


//    @Select("select * from pet")
//    List<Pet> findPetByAll(Pet pet);
//    
    @Delete("DELETE FROM pet WHERE pet_id = #{petId}")
    int petDelete(int petId);
    
    @Select("SELECT pet_id, member_id, pet_name, TO_CHAR(pet_DofB, 'YYYY-MM-DD') AS pet_DofB_fix, pet_kind, pet_breed"
    		+ ", TO_CHAR(pet_adoption, 'YYYY-MM-DD') AS pet_adoption_date_fix, pet_gender, pet_created_at FROM pet WHERE pet_id = #{petId}")
    Pet findPetById(int petId);
    
    @Update("UPDATE pet "
    		+ "SET pet_name = #{petName}"
    		+ ", pet_DofB = #{petDofBFix, jdbcType=DATE}"
    		+ ", pet_kind = #{petKind}"
    		+ ", pet_breed = #{petBreed}"
    		+ ", pet_weight = #{petWeight}"
    		+ ", pet_adoption = #{petAdoptionDateFix, jdbcType=DATE}"
    		+ ", pet_gender = #{petGender}"
    		+ "WHERE pet_id = #{petId}")
    int petUpdate(PetUpdateDto pet);

    @Select("select * from pet where member_id = #{reviewMemberId}")
	Pet findPetId(Pet pet);
    
	

    
//    @Delete("DELETE FROM pet WHERE pet_id = #{petId}")
//    int petDelete(int petId);
//
//    @Select("SELECT COUNT(*) FROM pet WHERE pet_id = #{petId}")
//    int findPetById(int petId);
//

	





	


	
}