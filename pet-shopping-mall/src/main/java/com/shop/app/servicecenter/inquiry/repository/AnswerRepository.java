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


	@Insert("insert into answer values(seq_answer_id.nextval, default, #{answerQuestionId}, #{answerContent}, default)")
	int insertAnswer(AnswerDetails answers);

	@Delete("delete from answer where answer_id = #{answerId}")
	int deleteAnswer(int answerId);

	@Update("update answer set answer_content = #{answerContent} where answer_id = #{answerId}")
	int updateAnswer(Answer answers);

}
