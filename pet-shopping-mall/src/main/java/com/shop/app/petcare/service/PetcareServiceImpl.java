package com.shop.app.petcare.service;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.petcare.dto.petReservationDto;
import com.shop.app.petcare.dto.petcareDto;
import com.shop.app.petcare.entity.PetcareDetails;

import lombok.extern.slf4j.Slf4j;

//@Transactional(rollbackFor = Exception.class) // service 단에 쓰는거임. 
//@Service
//@Slf4j
//public class PetcareServiceImpl implements PetcareService {
//
//	@Autowired
//	private PetcareRepository petcareRepository;
//	
//	public int insertReservation(petReservationDto petReservation) {
//		int result = 0;
//		result = petcareRepository.insertReservation(petReservation);
//		return result;
//	}
//
//}
