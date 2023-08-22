package com.shop.app.terms.entity;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import com.shop.app.member.entity.Required;
import com.shop.app.point.entity.Point;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Terms {

    private int historyId;
    private int termsId;
    private String memberId;
    private Accept termsAccept;  // 이용약관 동의 -> 무조건 Y로 저장
    private Accept privacyAccept;  // 개인정보 수집 및 이용에 대한 동의 -> 무조건 Y로 저장
    private Accept EmailAccept;  // 이벤트 등 프로모션 알림 메일 수신 동의 -> Y or N
    private Timestamp acceptDate;

    private char termsAcceptRequired;
    private char privacyAcceptRequired;
    private char emailAcceptRequired;
    
	private Required required;
	
	public void setRequired(Accept y) {
		
	}
    
    public Accept getEmailAccept() {
        return EmailAccept;
    }

    public void setEmailAccept(Accept EmailAccept) {
        this.EmailAccept = EmailAccept;
    }
    
    public Accept getAccept() {
        return EmailAccept;
    }
}
