package com.shop.app.member.service;

import java.util.List;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.entity.Member;


public interface MemberService {


	int insertMember(MemberCreateDto member);

	int updateMember(Member member);

	int deleteMember(Member member);

	Member findMemberById(String memberId);



}
