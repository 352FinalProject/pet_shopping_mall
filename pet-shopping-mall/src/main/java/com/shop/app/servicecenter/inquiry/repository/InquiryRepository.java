package com.shop.app.servicecenter.inquiry.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;

@Mapper
public interface InquiryRepository {
	

	// 1:1 목록 조회 질문 (예라)
	@Select("select id, member_id, title, content, reg_date from question")
	List<Question> findQuestionAll(Question question);

	@Select("select * from question where id = #{id}")
	Question findQuestionById(Question question);

	@Select("select * from answer where question_id = #{questionId}")
	Answer findQuestionAnswersById(Answer answer);

	// 1:1 목록 조회 답변 (예라)

}
