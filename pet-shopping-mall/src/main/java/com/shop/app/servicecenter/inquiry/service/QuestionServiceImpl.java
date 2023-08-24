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
	    
	    int refId = question.getQuestionId();
	    System.out.println("refId = " + refId);
	    
	    List<ImageAttachment> attachments = ((QuestionDetails) question).getAttachments();
	    if(attachments != null && !attachments.isEmpty()) {
	        for(ImageAttachment attach : attachments) {
	            
	            
	            // 1. 이미지 파일 DB에 저장
	            int result2 = questionRepository.insertAttachment(attach);
	            
	            // 2. 이미지 파일 DB 저장 후 생성된 이미지 ID를 가져온다
	            int imageId = attach.getImageId(); 
	            
	            // 3. 질문 ID와 이미지 ID를 사용하여 매핑 정보를 데이터베이스에 저장
	            int questionIdImageId = questionRepository.insertMapping(refId, imageId);
	        }
	    }
	    return result;
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

	// 이미지 파일 정보 조회 (예라)
	@Override
	public QuestionDetails findImageAttachmentsByQuestionId(int questionId) {
		return questionRepository.findImageAttachmentsByQuestionId(questionId);
	}

	// 1:1 문의 답변 카운트 (예라)
	@Override
	public Question findQuestionByAnwerCount(Question question) {
		return questionRepository.findQuestionByAnwerCount(question);
	}

	// 각 질문의 답변 수 계산하여 추가 (예라)
	@Override
	public int calculateAnswerCount(int questionId) {
		return questionRepository.calculateAnswerCount(questionId);
	}

}
