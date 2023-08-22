package com.shop.app.terms.entity;

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
    private Accept accept;
    private LocalDateTime acceptDate;

	public void setRequired(char c) {
		
	}
}
