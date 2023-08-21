 package com.shop.app.admin.service;

import java.util.List;
import java.util.Map;

import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.servicecenter.inquiry.entity.Question;


public interface AdminService {

	List<MemberDetails> adminMemberList();
	
	List<MemberDetails> adminSubscribeList();

	// 관리자 1:1 문의 전체 내역 조회 (예라)
	List<Question> findQuestionAll(Map<String, Object> params);

	// 관리자 1:1 문의 제목, 내용 검색 (예라)
	List<Question> questionSearch(String searchKeyword);

	// 관리자 1:1 문의 전체 카운트 (예라)
	int findTotalQuestionCount();
	
	List<MemberDetails> adminMemberSearchByNameOrId(String searchKeyword);
	
	List<MemberDetails> adminSubscribeSearchByNameOrId(String searchKeyword);

	int findTotalAdminCount();
	
	int findTotalubscribeCount();

	int updateMemberPoints(String memberId, int pointChange);

	




	

}