package com.shop.app.servicecenter.inquiry.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.shop.app.common.entity.Attachment;
import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;
import com.shop.app.servicecenter.inquiry.repository.QuestionRepository;

@Service
public class QuestionServiceImpl implements QuestionService {

	@Autowired
	private QuestionRepository questionRepository;
	
	// 1:1 목록 조회 질문 (예라)
	@Override
	public List<Question> findQuestionAll(Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return questionRepository.findQuestionAll(rowBounds);
	}
	
	// 1:1 목록 상세 조회 (예라)
	@Override
	public Question findQuestionById(Question question) {
		return questionRepository.findQuestionById(question);
	}
	
	// 1:1 목록 답변 조회 (예라)
	@Override
	public Answer findQuestionAnswersById(Answer answer) {
		return questionRepository.findQuestionAnswersById(answer);
	}

	// 1:1 문의 작성 (예라)
	@Override
	public int insertQuestion(Question question) {
		int result = 0;
		result = questionRepository.insertQuestion(question);
		
		List<Attachment> attachments = ((QuestionDetails) question).getAttachments();
		if(attachments != null && !attachments.isEmpty()) {
			for(Attachment attach : attachments) {
				attach.setImageId(question.getQuestionId());
				result = questionRepository.insertAttachment(attach);
			}
		}
		return  result;
	}
	
	// 1:1 문의 삭제 (예라)
	@Override
	public int deleteQuestion(int questionId) {
		return questionRepository.deleteQuestion(questionId);
	}

	// 1:1 문의 수정 (예라)
	@Override
	public int updateQuestion(Question question) {
		return questionRepository.updateQuestion(question);
	}

	
	// 1:1 문의 member_id 검색 (예라)
	@Override
	public Question findQuestionByMemberId(String memberId) {
		return questionRepository.findQuestionByMemberId(memberId);
	}

	// 1:1 문의 답변 조회 (예라)
	@Override
	public Answer findAnswersByContent(Answer answer) {
		return questionRepository.findAnswersByContent(answer);
	}

	// 1:1 문의 제목, 내용 검색 (예라)
	@Override
	public List<Question> questionSearch(String searchKeyword) {
		return questionRepository.questionSearch(searchKeyword);
	}

	// 1:1 문의 전체 카운트 (예라)
	@Override
	public int findTotalQuestionCount() {
		return questionRepository.findTotalQuestionCount();
	}
	

}
