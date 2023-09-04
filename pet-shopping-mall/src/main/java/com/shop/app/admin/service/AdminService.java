 package com.shop.app.admin.service;

import java.util.List;
import java.util.Map;

import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.servicecenter.inquiry.entity.Question;


public interface AdminService {

	List<MemberDetails> adminMemberList();
	
	List<MemberDetails> adminSubscribeList();

	List<Question> findQuestionAll(Map<String, Object> params);
	
	List<Question> questionSearch(String searchKeyword);

	int findTotalQuestionCount();
	
	List<MemberDetails> adminMemberSearchByNameOrId(String searchKeyword);
	
	List<MemberDetails> adminSubscribeSearchByNameOrId(String searchKeyword);

	int findTotalAdminCount();
	
	int findTotalubscribeCount();

	int updateMemberPoints(String memberId, int pointChange);

	




	

}