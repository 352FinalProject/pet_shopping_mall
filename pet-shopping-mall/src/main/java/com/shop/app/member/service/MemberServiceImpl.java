package com.shop.app.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.dto.MypageDto;
import com.shop.app.member.entity.Member;
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
		log.debug("memberDetails = {}", memberDetails);
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
	public MypageDto getMyPage(String memberId) {
		MypageDto myPage = memberRepository.getMyPage(memberId);
		List<Order> histories = orderRepository.getOrderListByPeriod(memberId, 1);
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


}
