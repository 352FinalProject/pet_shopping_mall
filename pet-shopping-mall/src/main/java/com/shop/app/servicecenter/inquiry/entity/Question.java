package com.shop.app.servicecenter.inquiry.entity;

import java.time.LocalDateTime;

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
	private String title;
	private String content;
	private LocalDateTime regDate;

}
