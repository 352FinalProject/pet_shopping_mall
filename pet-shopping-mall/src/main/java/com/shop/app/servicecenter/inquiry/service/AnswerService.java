package com.shop.app.servicecenter.inquiry.service;

import java.util.List;


import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.AnswerDetails;
import com.shop.app.servicecenter.inquiry.entity.Question;

public interface AnswerService {

	int insertAnswer(AnswerDetails answers);

	int deleteAnswer(int answerId);

	int updateAnswer(Answer answers);
	
}
