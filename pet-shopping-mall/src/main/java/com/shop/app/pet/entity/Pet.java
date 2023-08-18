package com.shop.app.pet.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
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