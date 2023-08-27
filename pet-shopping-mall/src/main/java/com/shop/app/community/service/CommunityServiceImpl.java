package com.shop.app.community.service;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.community.dto.CommunityCreateDto;
import com.shop.app.community.entity.CommunityDetails;
import com.shop.app.community.repository.CommunityRepository;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class) // service 단에 쓰는거임. 
@Service
@Slf4j
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityRepository communityRepository;
	

//	@Override
//	public int insertCommunity(CommunityDetails communities) {
//		int result = 0;
//		result = communityRepository.insertCommunity(communities);
//		return result;
//	}

}
