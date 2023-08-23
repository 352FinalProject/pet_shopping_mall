package com.shop.app.pet.entity;

import java.time.LocalDateTime;
import java.util.List;

import com.shop.app.point.entity.Point;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Builder
public class Pet {
	private int petId;
	private String memberId;
    private String petName;    
    private int petAge;
    private String petKind;
    private String petBreed;
    private String petWeight;
    private LocalDateTime petAdoptionDate;
    private PetGender petGender;
    private String petDofBFix;
    private String petAdoptionDateFix;
    
    private String reviewMemberId;
    

}