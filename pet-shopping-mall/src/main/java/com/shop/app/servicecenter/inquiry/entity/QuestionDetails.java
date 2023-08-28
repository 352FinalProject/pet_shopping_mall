package com.shop.app.servicecenter.inquiry.entity;

import java.util.List;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.common.entity.ImageAttachmentMapping;
import com.shop.app.member.entity.Member;

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
	
	private Member member;
	private List<ImageAttachment> attachments;
	private List<ImageAttachmentMapping> attachmentMapping;
	
}
