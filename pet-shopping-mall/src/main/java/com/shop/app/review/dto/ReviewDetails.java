package com.shop.app.review.dto;

import java.util.List;

import com.shop.app.common.entity.Attachment;
import com.shop.app.review.entity.Review;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;

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
public class ReviewDetails extends Review {
	
	private int reviewId;
	
	private List<Attachment> attachments;
	

}
