//package com.shop.app.petcare.repository;
//
//import org.apache.ibatis.annotations.Insert;
//import org.apache.ibatis.annotations.Mapper;
//import org.apache.ibatis.annotations.SelectKey;
//
//import com.shop.app.petcare.dto.petReservationDto;
//import com.shop.app.petcare.dto.petcareDto;
//import com.shop.app.petcare.entity.PetcareDetails;
//
////@Mapper
//public class PetcareRepository {
//
//	@Insert("insert into petcare (petcare_id, petcare_age, petcare_kind, petcare_breed, petcare_weight, petcare_gender, petcare_care_type, petcare_reservation_created_at ")
//	public int insertReservation(petReservationDto petReservation) {
//		return 0;
//	}
//
////	@Insert("insert into community (community_id, community_title, community_content, communtiy_created_at values(seq_community_id.nextval, #{communityTitle}, #{communityContent}, #{communityCreatedAt}")
////	@SelectKey(
////			before = false,
////			keyProperty = "communityId",
////			resultType = int.class,
////			statement = "select seq_community_id.currval from dual")
////	int insertCommunity(CommunityDetails communities);
//	
//
//}
