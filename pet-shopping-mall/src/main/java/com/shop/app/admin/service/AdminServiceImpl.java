 package com.shop.app.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.admin.repository.AdminRepository;
import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.servicecenter.inquiry.entity.Question;

@Transactional(rollbackFor = Exception.class) // 어떤예외가 발생하면 자동으로 롤백
@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminRepository adminRepository;

	@Override
	public List<MemberDetails> adminMemberList() {
		return adminRepository.adminMemberList();
	}
	
	@Override
	public List<MemberDetails> adminSubscribeList() {
		return adminRepository.adminSubscribeList();
	}
	
	@Override
	public List<MemberDetails> adminMemberSearchByNameOrId(String searchKeyword) {
	    return adminRepository.adminMemberSearchByNameOrId(searchKeyword);
	}	
	
	@Override
	public List<MemberDetails> adminSubscribeSearchByNameOrId(String searchKeyword) {
		return adminRepository.adminSubscribeSearchByNameOrId(searchKeyword);
	}

	@Override
	public List<Question> findQuestionAll(Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return adminRepository.findQuestionAll(rowBounds);
	}

	@Override
	public List<Question> questionSearch(String searchKeyword) {
		return adminRepository.questionSearch(searchKeyword);
	}
	
	@Override
	public int findTotalQuestionCount() {
		return adminRepository.findTotalQuestionCount();
	}

	@Override
	public int findTotalAdminCount() {
		return adminRepository.findTotalAdminCount();
	}
	
	@Override
	public int findTotalubscribeCount() {
		return adminRepository.findTotalubscribeCount();
	}
	
	@Override
	public int updateMemberPoints(String memberId, int pointChange) {
		return adminRepository.updateMemberPoints(memberId, pointChange);
	}
	

	

}
