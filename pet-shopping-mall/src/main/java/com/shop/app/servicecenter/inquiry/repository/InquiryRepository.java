package com.shop.app.servicecenter.inquiry.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;

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

	// 1:1 목록 삭제 (예라)
	@Delete("delete from question where id = #{id}")
	int deleteQuestion(int id);

	// 1:1 목록 수정 (예라)
	@Update("update question set member_id = #{memberId}, title = #{title}, content = #{content} where id = #{id}")
	int updateQuestion(Question question);

	// 1:1 퀘스쳔 아이디 검색 (예라)
	@Select("select * from question where id = #{id}")
	Question findById(int id);

}
