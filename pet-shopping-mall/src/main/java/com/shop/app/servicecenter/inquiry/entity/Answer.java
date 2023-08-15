package com.shop.app.servicecenter.inquiry.entity;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class Answer {
	
	private int answerId;
	private String answerAdminName;
	private int answerQuestionId;
	private String answerContent;
	private LocalDateTime answerCreatedAt;

	private int questionId;
}
