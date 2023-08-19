package com.shop.app.pet.entity;

import java.time.LocalDateTime;
import java.util.List;

import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Pet {
	private int petId;
	private String memberId;
    private String petName;    
    private LocalDateTime petDofB;
    private String petKind;
    private String petBreed;
    private LocalDateTime petAdoptionDate;
    private PetGender petGender; 
    

}