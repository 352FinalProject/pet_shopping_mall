package com.shop.app.member.service;



import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.entity.Member;


public interface MemberService {


	int insertMember(MemberCreateDto member);

	Member findMemberById(String memberId);

	int updateMember(Member member);

	Member deleteMember(String memberId);


}
