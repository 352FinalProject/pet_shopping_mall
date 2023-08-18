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
    
    // 이제 조회랑 등록 다 된다 그러면 삭제만 하면 될 것 가튼디??? 근데 왜 삭제 버튼은 안 만들엇어 10초몀ㄴ 됩니다 ㅎ..제가 너무 무능해서 잊엇던거 같아요,.,한번 만들어보삼

    
}