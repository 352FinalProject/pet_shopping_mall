//package com.shop.app.breed.repository;
//
//import java.util.List;
//
//import org.apache.ibatis.annotations.Delete;
//import org.apache.ibatis.annotations.Insert;
//import org.apache.ibatis.annotations.Mapper;
//import org.apache.ibatis.annotations.Select;
//import org.apache.ibatis.session.RowBounds;
//
//import com.shop.app.breed.dto.BreedCreateDto;
//import com.shop.app.pet.dto.PetCreateDto;
//import com.shop.app.pet.entity.Pet;
//
//
//
//
//@Mapper
//public interface BreedRepository {
//
//    @Insert("INSERT INTO breed (breed_id, pet_kind, pet_breed) " +
//            "VALUES (#{breedId}, #{petKind}, #{petBreed})")
//    int breedCreate(BreedCreateDto breedCreateDto);
//    
////    @Select("select * from pet")
////    List<Pet> findPetByAll(Pet pet);
////
////    @Delete("DELETE FROM pet WHERE pet_id = 1")
////    int petDelete(int petId);
//
//
////    @Select("SELECT * FROM pet WHERE pet_id = #{petId}")
////    Pet petDetail(int petId);
//
//
//	
//
//    
////    @Delete("DELETE FROM pet WHERE pet_id = #{petId}")
////    int petDelete(int petId);
////
////    @Select("SELECT COUNT(*) FROM pet WHERE pet_id = #{petId}")
////    int findPetById(int petId);
////
//
//	
//
//
//
//
//
//	
//
//
//	
//}