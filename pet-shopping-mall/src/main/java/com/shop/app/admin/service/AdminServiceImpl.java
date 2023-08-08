package com.shop.app.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.shop.app.admin.repository.AdminRepository;
import com.shop.app.member.entity.Member;

public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminRepository adminRepository;

	@Override
	public List<Member> findAllByMemberId(String memberId) {
		return adminRepository.findMemberById(memberId);
	}

	@Override
	public int insertMember(Member member) {
		return adminRepository.insertMember(member);
	}

	@Override
	public int updateMember(Member member) {
		return adminRepository.updateMember(member);
	}

	@Override
	public int deleteMember(Member member) {
		return adminRepository.deleteMember(member);
	}

	

}
