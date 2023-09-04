package com.shop.app.admin.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.servicecenter.inquiry.entity.Question;
@Mapper
public interface AdminRepository {
	
	@Select("select * from member order by enroll_date desc")
	List<MemberDetails> adminMemberList();
	
	@Select("select * from member where subscribe ='Y' order by enroll_date desc")
	List<MemberDetails> adminSubscribeList();
	
	@Select("select * from member where name like '%' || #{searchKeyword} || '%' or member_id like '%' || #{searchKeyword} || '%'")
	List<MemberDetails> adminMemberSearchByNameOrId(@Param("searchKeyword") String searchKeyword);
	
	@Select("select * from member where (name like '%' || #{searchKeyword} || '%' or member_id like '%' || #{searchKeyword} || '%') and subscribe = 'Y'")
	List<MemberDetails> adminSubscribeSearchByNameOrId(String searchKeyword);
	
	@Select("select q.*, (select count(*) from answer where answer_question_id = q.question_id) awnser_count from question q order by question_id desc")
	List<Question> findQuestionAll(RowBounds rowBounds);

	@Select("select count (*) from question")
	int findTotalQuestionCount();
	
	@Select("select * from question where question_title like '%' || #{searchKeyword} || '%' or question_content like '%' || #{searchKeyword} || '%'")
	List<Question> questionSearch(String searchKeyword);

	@Select("select count (*) from member")
	int findTotalAdminCount();

	@Select("select count (*) from member where subscribe ='Y' order by enroll_date desc")
	int findTotalubscribeCount();
	
	@Update("UPDATE point SET point_current = point_current + #{pointAmount}, point_amount = #{pointAmount}, point_type = '리뷰적립', point_date = SYSTIMESTAMP WHERE point_member_id = #{pointMemberId}")
	int updateMemberPoints(String memberId, int pointAmount);

}

