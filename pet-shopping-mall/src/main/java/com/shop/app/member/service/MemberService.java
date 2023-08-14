package com.shop.app.member.service;



import javax.validation.Valid;

//import org.springframework.security.core.userdetails.UserDetailsService;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.entity.Member;


public interface MemberService {

	int insertMember(MemberCreateDto member);

	Member findMemberById(String memberId);

	int updateMember(Member member);

	int deleteMember(Member member);

}
