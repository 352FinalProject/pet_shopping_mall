package com.shop.app.member.service;


import org.springframework.security.core.userdetails.UserDetailsService;


//import org.springframework.security.core.userdetails.UserDetailsService;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.dto.MypageDto;
import com.shop.app.member.entity.Member;
import com.shop.app.point.entity.Point;


public interface MemberService extends UserDetailsService {

	int insertMember(MemberCreateDto member);

	Member findMemberById(String memberId);

	int updateMember(Member member);

	int deleteMember(String memberId);

	Member findByEmail(String email);

	MypageDto getMyPage(String memberId);

}
