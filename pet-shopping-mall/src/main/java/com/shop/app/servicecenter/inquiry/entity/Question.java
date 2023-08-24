package com.shop.app.servicecenter.inquiry.entity;

import java.time.LocalDateTime;
import java.util.List;

import com.shop.app.common.entity.ImageAttachmentMapping;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;


@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class Question {
	
	private int questionId;
	private String questionMemberId;
	private String questionEmail;
	private String questionTitle;
	private String questionContent;
	private String questionCategory;
	private LocalDateTime questionCreatedAt;
	private int answerCount;
	private int imageId;
	
	List<Answer> answers;

}
