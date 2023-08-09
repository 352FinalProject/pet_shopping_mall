package com.shop.app.servicecenter.inquiry.dto;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class QuestionCreateDto {
	
	@NotBlank(message = "제목은 필수로 입력해야합니다.")
	private String title;
	
	@NotBlank(message = "내용은 필수로 입력해야합니다.")
	private String content;
}
