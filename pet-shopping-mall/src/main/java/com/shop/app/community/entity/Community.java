package com.shop.app.community.entity;

import java.sql.Date;
import java.time.LocalDateTime;

import com.shop.app.servicecenter.inquiry.entity.Answer;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class Community {
	
	private int communityId;
	private String communityMemberId;
	private String communityTitle;
	private String communityContent;
	private LocalDateTime communityCreatedAt;
	
	private int imageId;
	
}
