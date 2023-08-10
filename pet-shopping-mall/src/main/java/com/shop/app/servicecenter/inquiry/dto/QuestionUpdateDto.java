package com.shop.app.servicecenter.inquiry.dto;

import javax.validation.constraints.NotBlank;

import com.shop.app.servicecenter.inquiry.entity.Question;

public class QuestionUpdateDto {
	
	@NotBlank(message = "아이디는 필수로 입력해야합니다.")
	private String memberId;
	
	@NotBlank(message = "상품코드는 필수로 입력해야합니다.")
	private int productId;
	
	@NotBlank(message = "제목은 필수로 입력해야합니다.")
	private String title;
	
	@NotBlank(message = "내용은 필수로 입력해야합니다.")
	private String content;
	
	public Question toQuestion() {
		return Question.builder()
				.memberId(memberId)
				.productId(productId)
				.title(title)
				.content(content)
				.build();
	}
}