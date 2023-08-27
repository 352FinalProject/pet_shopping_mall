package com.shop.app.community.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.SelectKey;

import com.shop.app.community.dto.CommunityCreateDto;
import com.shop.app.community.entity.CommunityDetails;

//@Mapper
public class CommunityRepository {

//	@Insert("insert into community (community_id, community_title, community_content, communtiy_created_at values(seq_community_id.nextval, #{communityTitle}, #{communityContent}, #{communityCreatedAt}")
//	@SelectKey(
//			before = false,
//			keyProperty = "communityId",
//			resultType = int.class,
//			statement = "select seq_community_id.currval from dual")
//	int insertCommunity(CommunityDetails communities);
	

}
