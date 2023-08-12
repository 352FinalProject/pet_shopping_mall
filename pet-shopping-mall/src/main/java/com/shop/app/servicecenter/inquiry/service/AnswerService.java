package com.shop.app.servicecenter.inquiry.service;

import java.util.List;


import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.AnswerDetails;
import com.shop.app.servicecenter.inquiry.entity.Question;

public interface AnswerService {

	// 관리자 1:1 문의 댓글 작성 (예라)
	int insertAnswer(AnswerDetails answers);

	// 관리자 1:1 문의 댓글 삭제 (예라)
	int deleteAnswer(int answerId);

	// 관리자 1:1 문의 댓글 수정 (예라)
	int updateAnswer(Answer answers);
	
}
