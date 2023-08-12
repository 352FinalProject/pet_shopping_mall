package com.shop.app.servicecenter.inquiry.dto;

import javax.validation.constraints.NotBlank;

import com.shop.app.servicecenter.inquiry.entity.Question;

import lombok.Data;

@Data
public class QuestionCreateDto {
	
	@NotBlank(message = "아이디는 필수로 입력해야합니다.")
	private String questionMemberId;
	
	@NotBlank(message = "제목은 필수로 입력해야합니다.")
	private String questionTitle;
	
	@NotBlank(message = "카테고리는 필수로 입력해야합니다.")
	private String questionCategory;
	
	@NotBlank(message = "이메일은 필수로 입력해야합니다.")
	private String questionEmail;
	
	@NotBlank(message = "내용은 필수로 입력해야합니다.")
	private String questionContent;
	
	public Question toQuestion() {
		return Question.builder()
				.questionMemberId(questionMemberId)
				.questionTitle(questionTitle)
				.questionContent(questionContent)
				.questionCategory(questionCategory)
				.questionEmail(questionEmail)
				.build();
	}
}
