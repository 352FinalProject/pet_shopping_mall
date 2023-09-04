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



@Mapper
public interface PetRepository {

	@Insert("INSERT INTO pet (pet_id, member_id, pet_name, pet_age, pet_kind, pet_breed, pet_weight, pet_adoption, pet_gender) " +
	        "VALUES (seq_pet_id.nextval, #{memberId}, #{petName}, #{petAge}, #{petKind}, #{petBreed}, #{petWeight}, #{petAdoption, jdbcType=DATE}, #{petGender})")
	int petCreate(PetCreateDto pet);
	

	   @Select("SELECT * FROM pet WHERE member_id = #{memberId}")
	   List<Pet> findPetsByMemberId(String memberId);



    @Delete("DELETE FROM pet WHERE pet_id = #{petId}")
    int petDelete(int petId);
    
    @Select("SELECT pet_id, member_id, pet_name, pet_age, pet_kind, pet_breed, pet_weight"
    		+ ", TO_CHAR(pet_adoption, 'YYYY-MM-DD') AS pet_adoption_date_fix, pet_gender, pet_created_at FROM pet WHERE pet_id = #{petId}")
    Pet findPetById(int petId);
    
    @Update("UPDATE pet "
    		+ "SET pet_name = #{petName}"
    		+ ", pet_age = #{petAge}"
    		+ ", pet_kind = #{petKind}"
    		+ ", pet_breed = #{petBreed}"
    		+ ", pet_weight = #{petWeight}"
    		+ ", pet_adoption = #{petAdoptionDateFix, jdbcType=DATE}"
    		+ ", pet_gender = #{petGender}"
    		+ "WHERE pet_id = #{petId}")
    int petUpdate(PetUpdateDto pet);

    // 리뷰-펫 정보 가져오기(혜령)
    @Select("select * from pet where member_id = #{memberId}")
	List<Pet> findPetId(Pet pet, String memberId);

    // 상품 상세페이지 - 리뷰 - 펫 정보 가져오기 (혜령) 
    @Select("select * from pet where member_id = #{memberId}")
	List<Pet> findProductRevicePet(String memberId);

    @Select("SELECT p.pet_id, p.member_id, p.pet_name, p.pet_age, p.pet_kind, p.pet_breed, p.pet_weight, TO_CHAR(p.pet_adoption, 'YYYY-MM-DD') AS pet_adoption, p.pet_gender, p.pet_created_at " +
            "FROM pet p " +
            "WHERE p.member_id = #{reviewMemberId}")
    List<Pet> findReviewPetByMemberId(String reviewMemberId);

	

  

	





	


	
}