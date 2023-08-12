package com.shop.app.servicecenter.inquiry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.common.entity.Attachment;
import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;
import com.shop.app.servicecenter.inquiry.repository.InquiryRepository;

@Service
public class InquiryServiceImpl implements InquiryService {

	@Autowired
	private InquiryRepository inquiryRepository;
	
	// 1:1 목록 조회 질문 (예라)
	@Override
	public List<Question> findQuestionAll(Question question) {
		return inquiryRepository.findQuestionAll(question);
	}
	
	// 1:1 목록 상세 조회 (예라)
	@Override
	public Question findQuestionById(Question question) {
		return inquiryRepository.findQuestionById(question);
	}
	
	// 1:1 목록 답변 조회 (예라)
	@Override
	public Answer findQuestionAnswersById(Answer answer) {
		return inquiryRepository.findQuestionAnswersById(answer);
	}

	// 1:1 문의 작성 (예라)
	@Override
	public int insertQuestion(Question question) {
		int result = 0;
		result = inquiryRepository.insertQuestion(question);
		
		List<Attachment> attachments = ((QuestionDetails) question).getAttachments();
		if(attachments != null && !attachments.isEmpty()) {
			for(Attachment attach : attachments) {
				attach.setItemId(question.getId());
				result = inquiryRepository.insertAttachment(attach);
			}
		}
		return  result;
	}
	
	// 1:1 문의 삭제 (예라)
	@Override
	public int deleteQuestion(int id) {
		return inquiryRepository.deleteQuestion(id);
	}

	// 1:1 문의 수정 (예라)
	@Override
	public int updateQuestion(Question question) {
		return inquiryRepository.updateQuestion(question);
	}

	
	// 1:1 문의 member_id 검색 (예라)
	@Override
	public Question findQuestionByMemberId(String memberId) {
		return inquiryRepository.findQuestionByMemberId(memberId);
	}

	// 1:1 문의 답변 조회 (예라)
	@Override
	public Answer findAnswersByContent(Answer answer) {
		return inquiryRepository.findAnswersByContent(answer);
	}


}
