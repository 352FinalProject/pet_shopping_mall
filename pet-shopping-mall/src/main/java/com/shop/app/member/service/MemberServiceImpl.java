package com.shop.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.entity.Member;
import com.shop.app.member.repository.MemberRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberRepository memberRepository;

	@Override
	public int insertMember(MemberCreateDto member) {
		return memberRepository.insertMember(member);
	}

	@Override
	public Member findMemberById(String memberId) {
		return memberRepository.findMemberById(memberId);
	}

	@Override
	public int updateMember(Member member) {
		return memberRepository.updateMember(member);
	}

	@Override
	public int deleteMember(Member member) {
		return memberRepository.deleteMember(member);
	}



	// Spring Security에 의해 db 사용자를 조회할 때 사용
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserDetails memberDetails = memberRepository.loadUserByUsername(username);
		log.debug("memberDetails = {}", memberDetails);
		if(memberDetails == null)
			throw new UsernameNotFoundException(username);
		return memberDetails;
	}

}
