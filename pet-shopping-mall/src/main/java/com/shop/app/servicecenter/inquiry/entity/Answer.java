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
	
	private int answerId;
	private String answerAdminName;
	private int answerQuestionId;
	private String answerContent;
	private LocalDateTime answerCreatedAt;

}
