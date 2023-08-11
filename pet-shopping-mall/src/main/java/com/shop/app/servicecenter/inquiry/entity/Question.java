package com.shop.app.servicecenter.inquiry.entity;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;


@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class Question {
	
	private int id;
	private String memberId;
	private int productId;
	private String title;
	private String content;
	private LocalDateTime regDate;
	private int answerCnt;
	
	List<Answer> answers;

}
