package com.shop.app.servicecenter.inquiry.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.AnswerDetails;
import com.shop.app.servicecenter.inquiry.entity.Question;

@Mapper
public interface AnswerRepository {


	// 관리자 1:1 문의 댓글 작성 (예라)
	@Insert("insert into answer values(seq_answer_id.nextval, #{answerAdminName}, #{answerQuestionId}, #{answerContent}, default)")
	int insertAnswer(AnswerDetails answers);

	// 관리자 1:1 문의 댓글 삭제 (예라)
	@Delete("delete from answer where answer_id = #{answerId}")
	int deleteAnswer(int answerId);
	
	// 관리자 1:1 문의 댓글 수정 (예라)
	@Update("update answer set answer_content = #{answerContent} where answer_id = #{answerId}")
	int updateAnswer(Answer answers);

}
