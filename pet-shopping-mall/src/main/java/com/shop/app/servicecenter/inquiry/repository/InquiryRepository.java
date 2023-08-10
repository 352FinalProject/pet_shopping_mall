package com.shop.app.servicecenter.inquiry.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;

@Mapper
public interface InquiryRepository {
	

	// 1:1 목록 조회 질문 (예라)
	@Select("select id, member_id, product_id, title, content, reg_date from question")
	List<Question> findQuestionAll(Question question);

	// 1:1 목록 상세 조회 (예라)
	@Select("select * from question where id = #{id}")
	Question findQuestionById(Question question);

	// 1:1 목록 답변 조회 (예라)
	@Select("select * from answer where question_id = #{questionId}")
	Answer findQuestionAnswersById(Answer answer);

	// 1:1 목록 작성 (예라)
	@Insert("insert into question values(seq_question_id.nextval, #{memberId}, #{productId}, #{title}, #{content}, default)")
	int insertQuestion(Question question);

}
