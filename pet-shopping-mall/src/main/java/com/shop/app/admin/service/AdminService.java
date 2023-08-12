 package com.shop.app.admin.service;

import java.util.List;
import java.util.Map;

import com.shop.app.member.entity.Member;
import com.shop.app.servicecenter.inquiry.entity.Question;


public interface AdminService {

	List<Member> adminMemberList(Map<String, Object> params);
	
	int insertMember(Member member);

	int updateMember(Member member);

	int deleteMember(Member member);

	// 관리자 1:1 문의 전체 내역 조회 (예라)
	List<Question> findQuestionAll(Question question);

}

	List<Member> adminMemberSearchByNameOrId(String searchKeyword);

	

}