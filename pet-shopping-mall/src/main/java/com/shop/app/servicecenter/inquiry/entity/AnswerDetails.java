package com.shop.app.servicecenter.inquiry.entity;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder 
public class AnswerDetails extends Question{

	private int answerQuestionId;
	private String answerContent;
	private String answerAdminName;
	
}
