package com.shop.app.petcare.entity;

import java.sql.Date;
import java.time.LocalDateTime;

import com.shop.app.servicecenter.inquiry.entity.Answer;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class Petcare {
	
	private int petcareId;
	private String petcareMemberId;
	private int petcarePetId;
	private int petcareCareType; // 1.일반진료 2.예방접종 3.건강검진 4.상담진료
	private LocalDateTime petcareReservationCreatedAt;
	
}
