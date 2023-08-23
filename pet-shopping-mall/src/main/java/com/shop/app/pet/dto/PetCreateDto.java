package com.shop.app.pet.dto;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberRole;
import com.shop.app.member.entity.Subscribe;
import com.shop.app.pet.entity.PetGender;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PetCreateDto {


	private int petId; // 혜령 추가

	private String memberId;
	
	@NotBlank(message = "펫 이름을 입력해주세요.")
    private String petName;    
	
	@NotBlank(message = "나이를 입력해 주세요") // 이부분 추가
    private String petAge;
	
	@NotBlank(message = "반려동물 종류를 입력해주세요.")
    private String petKind;
	
	@NotBlank(message = "반려동물 품종을 입력해주세요.")
    private String petBreed;
	
	@NotBlank(message = "반려동물 몸무게를 입력해주세요.")
	private String petWeight;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd") // 이부분 추가
    private LocalDate petAdoption;
	
	@NotNull(message = "성별을 입력해주세요.")
    private PetGender petGender;


}