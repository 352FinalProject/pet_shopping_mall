package com.shop.app.servicecenter.inquiry.entity;

import java.time.LocalDateTime;
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
public class QuestionDetails extends Question{

	private int answerCount;
	private int questionId;

	List<Answer> answers;
	
}