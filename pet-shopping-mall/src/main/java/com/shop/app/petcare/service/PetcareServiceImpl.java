package com.shop.app.petcare.service;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.petcare.dto.PetcareDto;
import com.shop.app.petcare.entity.PetcareDetails;
import com.shop.app.petcare.repository.PetcareRepository;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class) // service 단에 쓰는거임. 
@Service
@Slf4j
public class PetcareServiceImpl implements PetcareService {

//	@Autowired
//	private CommunityRepository communityRepository;
	

//	@Override
//	public int insertCommunity(CommunityDetails communities) {
//		int result = 0;
//		result = communityRepository.insertCommunity(communities);
//		return result;
//	}

}
