package com.shop.app.pet.dto;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;

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

	@NotBlank(message = "펫 이름을 입력해주세요.")
    private String petName;    
	
	@NotBlank(message = "생년월일을 입력해주세요.")
    private LocalDateTime petDofB;
	
	@NotBlank(message = "생년월일을 입력해주세요.")
    private String petKind;
	
	@NotBlank(message = "생년월일을 입력해주세요.")
    private String petBreed;
	
	@NotBlank(message = "생년월일을 입력해주세요.")
    private LocalDateTime petAdoptionDate;
	
	@NotBlank(message = "생년월일을 입력해주세요.")
    private PetGender petGender;

    // 생성자, getter, setter 메서드
}