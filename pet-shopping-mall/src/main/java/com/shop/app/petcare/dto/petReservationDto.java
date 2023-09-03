package com.shop.app.petcare.dto;

import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;

import com.shop.app.pet.entity.Pet;
import com.shop.app.pet.entity.PetGender;
import com.shop.app.petcare.entity.Petcare;
import com.shop.app.review.dto.ProductReviewAvgDto;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class petReservationDto {
	
	private int petcareId;
	//private String petcareMemberId;
	//private int petcarePetId;
	
	@NotBlank(message = "예약하실 진료를 입력해주세요.")
	private int petcareCareType; // 1.일반진료 2.예방접종 3.건강검진 4.상담진료
	private LocalDateTime petcareReservationCreatedAt;
	
	@NotBlank(message = "반려동물의 이름을 입력해주세요.")
	private String petName;
	
	private int petAge;

	@NotBlank(message = "반려동물의 종을 입력해주세요.")
	private String petKind;
	
    private String petBreed;
    private String petWeight;
    
    @NotBlank(message = "반려동물의 성별을 입력해주세요.")
    private PetGender petGender;
    private String petDofBFix;
	
//	public Petcare toPetcare() {
//		return Petcare.builder()
//				.petcareId(petcareId)
//				.petcareMemberId(petcareMemberId)
//				.petcarePetId(petcarePetId)
//				.petcareCareType(petcareCareType)
//				.petcareReservationCreatedAt(petcareReservationCreatedAt)
//				.build();
//	}
	
	
	// pet
//	@NotBlank(message = "반려동물의 이름을 입력해주세요.")
//	private String petName;
//	
//	private int petAge;
//
//	@NotBlank(message = "반려동물의 종을 입력해주세요.")
//	private String petKind;
//	
//    private String petBreed;
//    private String petWeight;
//    
//    @NotBlank(message = "반려동물의 성별을 입력해주세요.")
//    private PetGender petGender;
//    private String petDofBFix;
//    
    
    
    

}
