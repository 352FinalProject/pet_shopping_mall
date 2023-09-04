package com.shop.app.servicecenter.inquiry.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;

@Mapper
public interface QuestionRepository {
	
	@Select("select q.*, (select count(*) from answer where answer_question_id = q.question_id) answer_count from question q order by question_id desc")
	List<QuestionDetails> findQuestionAll(RowBounds rowBounds);

	@Select("select * from question where question_id = #{questionId}")
	Question findQuestionById(Question question);

	@Select("select * from answer where answer_question_id = #{answerQuestionId}")
	Answer findQuestionAnswersById(Answer answer);

	int insertQuestion(Question question);

	int insertAttachment(ImageAttachment attach);

	@Delete("delete from question where question_id = #{questionId}")
	int deleteQuestion(int questionId);

	@Update("update question set question_member_id = #{questionMemberId}, question_title = #{questionTitle}, question_category = #{questionCategory}, question_email = #{questionEmail}, question_content = #{questionContent} where question_id = #{questionId}")
	int updateQuestion(Question question);

	@Select("select * from question where question_member_id = #{questionMemberId}")
	Question findQuestionByMemberId(String memberId);

	@Select("select * from answer where answer_content = #{answerContent}")
	Answer findAnswersByContent(Answer answer);

	@Select("select * from question where question_title like '%' || #{searchKeyword} || '%' or question_content like '%' || #{searchKeyword} || '%'")
	List<Question> questionSearch(String searchKeyword);

	@Select("select count (*) from question")
	int findTotalQuestionCount();

	@Insert("insert into image_attachment_mapping (mapping_id, ref_table, ref_id, image_id) VALUES (seq_image_attachment_mapping_id.nextval, 'question', #{questionId}, #{imageId})")
	int insertMapping(int questionId, int imageId);

	QuestionDetails findImageAttachmentsByQuestionId(int questionId);

	@Select("select q.*, (select count(*) from answer where answer_question_id = q.question_id) answer_count from question q where q.question_id = #{questionId} order by question_id desc")
	Question findQuestionByAnwerCount(Question question);

	@Select("select q.*, (select count(*) from answer where answer_question_id = q.question_id) answer_count from question q where q.question_id = #{questionId} order by question_id desc")
	int calculateAnswerCount(int questionId);

	ImageAttachment findAttachmentById(int questionId);
	

}
