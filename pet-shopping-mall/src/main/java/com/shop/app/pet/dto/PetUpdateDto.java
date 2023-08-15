//package com.shop.app.pet.dto;
//
//import java.time.LocalDateTime;
//
//import javax.validation.constraints.NotBlank;
//import javax.validation.constraints.NotNull;
//
//import com.shop.app.pet.entity.Pet; // Pet 엔티티 임포트 추가
//
//import lombok.Data;
//
//@Data
//public class PetUpdateDto {
//	@NotBlank(message = "펫 아이디는 필수입니다.")
//    private Integer petId;
//    
//    private String petName;
//    private LocalDateTime petDofB;
//    private String petKind;
//    private String petBreed;
//    private LocalDateTime petAdoptionDate;
//    private char petGender;
//
//    public Pet toPet() {
//        return Pet.builder()
//                .petId(petId)
//                .petName(petName)
//                .petDofB(petDofB)
//                .petKind(petKind)
//                .petBreed(petBreed)
//                .petAdoptionDate(petAdoptionDate)
//                .petGender(petGender)
//                .build();
//    }
//}
