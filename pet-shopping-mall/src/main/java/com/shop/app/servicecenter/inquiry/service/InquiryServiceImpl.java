package com.shop.app.servicecenter.inquiry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		return inquiryRepository.insertQuestion(question);
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

	// 1:1 퀘스쳔 아이디 검색 (예라)
	@Override
	public Question findById(int id) {
		return inquiryRepository.findById(id);
	}

}
