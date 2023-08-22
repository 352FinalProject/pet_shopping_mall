package com.shop.app.pet.entity;

import java.time.LocalDateTime;
import java.util.List;


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
    private String petAge;
    private String petKind;
    private String petBreed;
    private String petWeight;
    private LocalDateTime petAdoptionDate;
    private PetGender petGender;
    private String petDofBFix;
    private String petAdoptionDateFix;
    
    

}