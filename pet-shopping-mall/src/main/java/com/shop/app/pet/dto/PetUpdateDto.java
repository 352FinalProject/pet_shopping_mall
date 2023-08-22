	package com.shop.app.pet.dto;
	
	import lombok.AllArgsConstructor;
	import lombok.Builder;
	import lombok.Data;
	import lombok.NoArgsConstructor;
	
	import javax.validation.constraints.NotEmpty;
	import java.time.LocalDate;
	
	@Data
	@NoArgsConstructor
	@AllArgsConstructor
	@Builder
	public class PetUpdateDto {
	    private Long petId;
	    private String memberId;
	    private String petName;
	    private String petAge;
	    private String petKind;
	    private String petBreed;
	    private String petWeight;
	    private LocalDate petAdoptionDate;
	    private String petGender;
	    private String petAdoptionDateFix;
	}