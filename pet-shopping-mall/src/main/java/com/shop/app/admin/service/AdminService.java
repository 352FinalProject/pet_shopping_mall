 package com.shop.app.admin.service;

import java.util.List;
import java.util.Map;

import com.shop.app.member.entity.Member;


public interface AdminService {

	List<Member> adminMemberList(Map<String, Object> params);
	
	int insertMember(Member member);

	int updateMember(Member member);

	int deleteMember(Member member);

	List<Member> adminMemberSearchByNameOrId(String searchKeyword);

	

}