package com.shop.app.servicecenter.inquiry.service;

import java.util.List;
import java.util.Map;

import com.shop.app.common.entity.imageAttachment;
import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;

public interface QuestionService {

	// 1:1 목록 조회 질문 (예라)
	List<Question> findQuestionAll(Map<String, Object> params);

	// 1:1 목록 상세 조회 (예라)
	Question findQuestionById(Question question);
	
	// 1:1 목록 답변 조회 (예라)
	Answer findQuestionAnswersById(Answer answer);

	// 1:1 문의 작성 (예라)
	int insertQuestion(Question question);

	// 1:1 문의 삭제 (예라)
	int deleteQuestion(int questionId);

	// 1:1 문의 수정 (예라)
	int updateQuestion(Question question);

	// 1:1 문의 member_id 검색 (예라)
	Question findQuestionByMemberId(String memberId);

	// 1:1 문의 답변 조회 (예라)
	Answer findAnswersByContent(Answer answer);

	// 1:1 문의 제목, 내용 검색 (예라)
	List<Question> questionSearch(String searchKeyword);

	// 1:1 문의 전체 카운트 (예라)
	int findTotalQuestionCount();

	// 이미지 파일 정보 조회 (예라)
	QuestionDetails findImageAttachmentsByQuestionId(int questionId);

	// 1:1 문의 답변 카운트 (예라)
	Question findQuestionByAnwerCount(Question question);

	// 각 질문의 답변 수 계산하여 추가 (예라)
	int calculateAnswerCount(int questionId);
	
}
