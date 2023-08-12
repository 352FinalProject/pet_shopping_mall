package com.shop.app.admin.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.member.entity.Member;
import com.shop.app.servicecenter.inquiry.entity.Question;
@Mapper
public interface AdminRepository {
	
	@Select("select * from member where member_id = #{memberId}")
	List<Member> findMemberById(String memberId);
	
	@Insert("insert into member values ()")
	int insertMember(Member member);
	
	@Update("update member set birthday =")
	int updateMember(Member member);
	
	@Delete("delete memeber where id = #{memberId}")
	int deleteMember(Member member);

	// 관리자 1:1 문의 전체 내역 조회 (예라)
	@Select("select q.*, (select count(*) from answer where answer_question_id = q.question_id) awnser_count from question q order by question_id desc")
	List<Question> findQuestionAll(Question question);

}
