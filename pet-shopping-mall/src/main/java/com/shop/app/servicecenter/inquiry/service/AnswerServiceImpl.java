package com.shop.app.servicecenter.inquiry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.shop.app.common.entity.Attachment;
import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.AnswerDetails;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;
import com.shop.app.servicecenter.inquiry.repository.AnswerRepository;
import com.shop.app.servicecenter.inquiry.repository.QuestionRepository;

@Service
public class AnswerServiceImpl implements AnswerService {

	@Autowired
	private AnswerRepository answerRepository;

	// 관리자 1:1 문의 댓글 작성 (예라)
	@Override
	public int insertAnswer(AnswerDetails answers) {
		return answerRepository.insertAnswer(answers);
	}

	// 관리자 1:1 문의 댓글 삭제 (예라)
	@Override
	public int deleteAnswer(int answerId) {
		return answerRepository.deleteAnswer(answerId);
	}

	// 관리자 1:1 문의 댓글 수정 (예라)
	@Override
	public int updateAnswer(Answer answers) {
		return answerRepository.updateAnswer(answers);
	}
	
	
}
