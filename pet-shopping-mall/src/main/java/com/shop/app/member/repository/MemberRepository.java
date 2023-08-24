package com.shop.app.member.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.dto.MypageDto;
import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;

@Mapper
public interface MemberRepository {

	@Select("select * from member where member_id = #{memberId}")
	Member findMemberById(String memberId);

	@Insert("INSERT INTO member VALUES (#{memberId}, #{password}, #{name, jdbcType=VARCHAR}, #{phone, jdbcType=VARCHAR}, #{email, jdbcType=VARCHAR}, default, #{address, jdbcType=VARCHAR}, #{birthday, jdbcType=DATE}, default)")
	int insertMember(MemberCreateDto member);

	@Update("update member set name = #{name}, password = #{password}, email = #{email} where member_id = #{memberId}")
	int updateMember(Member member);

	@Delete("delete from member where member_id = #{memberId}")
	int deleteMember(String memberId);

	MemberDetails loadUserByUsername(String username);

	
	@Select("select * from member where name=#{name} and email=#{email}")
	public String memberSearchId(@Param("name") String name, @Param("email") String email);

	@Select("select * from member where email=#{email}")
	Member findByEmail(String email);

	List<Member> findThisMonthBirthdayMembers(int currentMonth);

	MypageDto getMyPage(String memberId);
	

	
}
