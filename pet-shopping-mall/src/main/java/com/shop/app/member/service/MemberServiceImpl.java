package com.shop.app.member.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.dto.MypageDto;
import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.SubMember;
import com.shop.app.member.repository.MemberRepository;
import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.entity.Order;
import com.shop.app.order.repository.OrderRepository;
import com.shop.app.point.entity.Point;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private OrderRepository orderRepository;
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
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserDetails memberDetails = memberRepository.loadUserByUsername(username);
		if (memberDetails == null)
			throw new UsernameNotFoundException(username);
		return memberDetails;
	}

	@Override
	public int deleteMember(String memberId) {
		return memberRepository.deleteMember(memberId);
		
	}

	@Override
	public Member findByEmail(String email) {
		return memberRepository.findByEmail(email);
	}

	@Override
	public MypageDto getMyPage(String memberId,  Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		MypageDto myPage = memberRepository.getMyPage(memberId);
		List<Order> histories = orderRepository.getOrderListByPeriod(memberId, 1, rowBounds);
		
		SubMember subMember = null;
		
		if((myPage.getSubscribe()).equals("Y")) {
			subMember = memberRepository.findSubMemberByMemberId(memberId);
		}
		
		myPage.setSubMember(subMember);
		myPage.setOrderHistory(histories);
		return myPage;
	}

	@Override
	public int memberSubscribe(String memberId) {
		return memberRepository.memberSubscribe(memberId);
	}
	
	@Override
	public int subscribeCancel(String memberId) {
		return memberRepository.subscribeCancel(memberId);
	}
	
	
	@Override
	public SubMember findSubMemberByMemberId(String memberId) {
		return memberRepository.findSubMemberByMemberId(memberId);
	}

	@Override
	public int cancelSubscribe(String memberId) {
		return memberRepository.cancelSubscribe(memberId);
	}

	@Override
	public int updateCancelSubscribers() {
		List<SubMember> subMembers = memberRepository.updateCancelSubscribers();
		int result = 0;
		for(SubMember s : subMembers) {
			result = memberRepository.subscribeCancel(s.getMemberId());
		}
		return result; 
	}

	@Override
	public MypageDto getMyPage(String memberId) {
		MypageDto myPage = memberRepository.getMyPage(memberId);
		
		SubMember subMember = null;
		
		if((myPage.getSubscribe()).equals("Y")) {
			subMember = memberRepository.findSubMemberByMemberId(memberId);
		}
		
		myPage.setSubMember(subMember);
		return myPage;
	}
}
