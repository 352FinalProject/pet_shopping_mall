package com.shop.app.servicecenter.inquiry.dto;

import javax.validation.constraints.NotBlank;

import com.shop.app.servicecenter.inquiry.entity.Answer;

import lombok.Data;

@Data
public class AnswerUpdateDto {
	
	private int answerId;
	
	@NotBlank(message = "내용은 필수로 입력해야합니다.")
	private String answerContent;
	
	public Answer toAnswer() {
	    return Answer.builder()
	            .answerContent(answerContent)
	            .answerId(answerId)
	            .build();
	}
}