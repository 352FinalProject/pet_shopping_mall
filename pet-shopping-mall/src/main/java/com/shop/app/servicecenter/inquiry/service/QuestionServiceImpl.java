package com.shop.app.servicecenter.inquiry.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;
import com.shop.app.servicecenter.inquiry.repository.QuestionRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class QuestionServiceImpl implements QuestionService {

	@Autowired
	private QuestionRepository questionRepository;
	
	@Override
	public List<QuestionDetails> findQuestionAll(Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return questionRepository.findQuestionAll(rowBounds);
	}


	@Override
	public Question findQuestionById(Question question) {
		return questionRepository.findQuestionById(question);
	}

	@Override
	public Answer findQuestionAnswersById(Answer answer) {
		return questionRepository.findQuestionAnswersById(answer);
	}

	@Override
	public int insertQuestion(Question question) {
	    int result = 0;
	    result = questionRepository.insertQuestion(question);
	    
	    int refId = question.getQuestionId();
	    
	    List<ImageAttachment> attachments = ((QuestionDetails) question).getAttachments();
	    if(attachments != null && !attachments.isEmpty()) {
	        for(ImageAttachment attach : attachments) {
	            
	            int result2 = questionRepository.insertAttachment(attach);
	            
	            int imageId = attach.getImageId(); 
	            
	            int questionIdImageId = questionRepository.insertMapping(refId, imageId);
	        }
	    }
	    return result;
	}
	
	@Override
	public int deleteQuestion(int questionId) {
		return questionRepository.deleteQuestion(questionId);
	}

	@Override
	public int updateQuestion(Question question) {
		return questionRepository.updateQuestion(question);
	}

	@Override
	public Question findQuestionByMemberId(String memberId) {
		return questionRepository.findQuestionByMemberId(memberId);
	}

	@Override
	public Answer findAnswersByContent(Answer answer) {
		return questionRepository.findAnswersByContent(answer);
	}

	@Override
	public List<Question> questionSearch(String searchKeyword) {
		return questionRepository.questionSearch(searchKeyword);
	}

	@Override
	public int findTotalQuestionCount() {
		return questionRepository.findTotalQuestionCount();
	}

	@Override
	public QuestionDetails findImageAttachmentsByQuestionId(int questionId) {
		return questionRepository.findImageAttachmentsByQuestionId(questionId);
	}

	@Override
	public Question findQuestionByAnwerCount(Question question) {
		return questionRepository.findQuestionByAnwerCount(question);
	}

	@Override
	public int calculateAnswerCount(int questionId) {
		return questionRepository.calculateAnswerCount(questionId);
	}

	@Override
	public ImageAttachment findAttachmentById(int questionId) {
		return questionRepository.findAttachmentById(questionId);
	}

}
