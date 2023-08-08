package com.shop.app.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.entity.Member;
import com.shop.app.member.repository.MemberRepository;

public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberRepository memberRepository;

	@Override
	public Member findMemberById(String memberId) {
		return memberRepository.findMemberById(memberId);
	}

	@Override
	public int insertMember(MemberCreateDto member) {
		return memberRepository.insertMember(member);
	}

	@Override
	public int updateMember(Member member) {
		return memberRepository.updateMember(member);
	}

	@Override
	public int deleteMember(Member member) {
		return memberRepository.deleteMember(member);
	}



	

}
