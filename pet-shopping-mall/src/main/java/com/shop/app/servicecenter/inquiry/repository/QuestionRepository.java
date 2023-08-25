package com.shop.app.servicecenter.inquiry.repository;

import java.util.List;

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
	

	// 1:1 목록 조회 질문 (예라)
	@Select("select q.*, (select count(*) from answer where answer_question_id = q.question_id) answer_count from question q order by question_id desc")
	List<Question> findQuestionAll(RowBounds rowBounds);

	// 1:1 목록 상세 조회 (예라)
	@Select("select * from question where question_id = #{questionId}")
	Question findQuestionById(Question question);

	// 1:1 목록 답변 조회 (예라)
	@Select("select * from answer where answer_question_id = #{answerQuestionId}")
	Answer findQuestionAnswersById(Answer answer);

	// 1:1 목록 작성 (예라)
	int insertQuestion(Question question);
	
	// 1:1 문의 파일 첨부 (예라)
	int insertAttachment(ImageAttachment attach);

	// 1:1 목록 삭제 (예라)
	@Delete("delete from question where question_id = #{questionId}")
	int deleteQuestion(int questionId);

	// 1:1 목록 수정 (예라)
	@Update("update question set question_member_id = #{questionMemberId}, question_title = #{questionTitle}, question_category = #{questionCategory}, question_email = #{questionEmail}, question_content = #{questionContent} where question_id = #{questionId}")
	int updateQuestion(Question question);

	// 1:1 문의 member_id 검색 (예라)
	@Select("select * from question where question_member_id = #{questionMemberId}")
	Question findQuestionByMemberId(String memberId);

	// 1:1 문의 답변 내용 조회 (예라)
	@Select("select * from answer where answer_content = #{answerContent}")
	Answer findAnswersByContent(Answer answer);

	// 1:1 문의 제목, 내용 검색 (예라)
	@Select("select * from question where question_title like '%' || #{searchKeyword} || '%' or question_content like '%' || #{searchKeyword} || '%'")
	List<Question> questionSearch(String searchKeyword);

	// 1:1 문의 전체 카운트 (예라)
	@Select("select count (*) from question")
	int findTotalQuestionCount();

	// 질문 ID와 이미지 ID를 사용하여 매핑 정보를 DB에 저장 (예라)
	@Insert("insert into image_attachment_mapping (mapping_id, ref_table, ref_id, image_id) VALUES (seq_image_attachment_mapping_id.nextval, 'question', #{questionId}, #{imageId})")
	int insertMapping(int questionId, int imageId);

	// 이미지 파일 정보 조회 (예라)
	QuestionDetails findImageAttachmentsByQuestionId(int questionId);

	// 1:1 문의 답변 카운트 (예라)
	@Select("select q.*, (select count(*) from answer where answer_question_id = q.question_id) answer_count from question q where q.question_id = #{questionId} order by question_id desc")
	Question findQuestionByAnwerCount(Question question);

	// 각 질문의 답변 수 계산하여 추가 (예라)
	@Select("select q.*, (select count(*) from answer where answer_question_id = q.question_id) answer_count from question q where q.question_id = #{questionId} order by question_id desc")
	int calculateAnswerCount(int questionId);

}
