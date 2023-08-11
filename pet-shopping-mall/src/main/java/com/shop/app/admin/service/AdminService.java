package com.shop.app.admin.service;

import java.util.List;

import com.shop.app.member.entity.Member;


public interface AdminService {

	List<Member> findAllByMemberId(String memberId);

	int insertMember(Member member);

	int updateMember(Member member);

	int deleteMember(Member member);

}
