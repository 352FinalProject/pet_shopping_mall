package com.shop.app.servicecenter.inquiry.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Answer {
	
	private int id;
	private String adminName;
	private int questionId;
	private String content;
	private LocalDateTime regDate;

}
