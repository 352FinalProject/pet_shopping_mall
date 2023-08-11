package com.shop.app.servicecenter.inquiry.service;

import java.util.List;

import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;

public interface InquiryService {

	// 1:1 목록 조회 질문 (예라)
	List<Question> findQuestionAll(Question question);

	// 1:1 목록 상세 조회 (예라)
	Question findQuestionById(Question question);
	
	// 1:1 목록 답변 조회 (예라)
	Answer findQuestionAnswersById(Answer answer);

	// 1:1 문의 작성 (예라)
	int insertQuestion(Question question);

	// 1:1 문의 삭제 (예라)
	int deleteQuestion(int id);

	// 1:1 문의 수정 (예라)
	int updateQuestion(Question question);

	// 1:1 문의 member_id 검색 (예라)
	Question findQuestionByMemberId(String memberId);

	// 1:1 문의 답변 조회 (예라)
	Answer findAnswersByContent(String content);
	
}
