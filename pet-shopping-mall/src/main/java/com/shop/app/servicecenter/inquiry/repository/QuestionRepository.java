package com.shop.app.servicecenter.inquiry.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.common.entity.Attachment;
import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;

@Mapper
public interface QuestionRepository {
	

	// 1:1 목록 조회 질문 (예라)
	@Select("select q.*, (select count(*) from answer where answer_question_id = q.question_id) awnser_count from question q order by question_id desc")
	List<Question> findQuestionAll(Question question);

	// 1:1 목록 상세 조회 (예라)
	@Select("select * from question where question_id = #{questionId}")
	Question findQuestionById(Question question);

	// 1:1 목록 답변 조회 (예라)
	@Select("select * from answer where answer_question_id = #{answerQuestionId}")
	Answer findQuestionAnswersById(Answer answer);

	// 1:1 목록 작성 (예라)
	@Insert("insert into question values(seq_question_question_id.nextval, #{questionMemberId}, #{questionCategory}, #{questionEmail}, #{questionTitle}, #{questionContent}, default)")
	int insertQuestion(Question question);
	
	// 1:1 문의 파일 첨부 (예라)
	@Insert("insert into image_attachment values(seq_image_attachment_image_id.nextval, #{imageType}, #{imageCategory}, #{imageOriginalFilename}, #{imageRenamedfilename}, #{imageFileSize}, default)")
	int insertAttachment(Attachment attach);

	// 1:1 목록 삭제 (예라)
	@Delete("delete from question where question_id = #{questionId}")
	int deleteQuestion(int id);

	// 1:1 목록 수정 (예라)
	@Update("update question set question_member_id = #{questionMemberId}, question_title = #{questionTitle}, question_category = #{questionCategory}, question_email = #{questionEmail}, question_content = #{questionContent} where question_id = #{questionId}")
	int updateQuestion(Question question);

	// 1:1 문의 member_id 검색 (예라)
	@Select("select * from question where question_member_id = #{questionMemberId}")
	Question findQuestionByMemberId(String memberId);

	// 1:1 문의 답변 내용 조회 (예라)
	@Select("select * from answer where answer_content = #{answerContent}")
	Answer findAnswersByContent(Answer answer);

}
