package com.shop.app.member.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.oauth.dto.KakaoMemberCreateDto;

@Mapper
public interface MemberRepository {

	@Select("select * from member where member_id = #{memberId}")
	Member findMemberById(String memberId);

	@Insert("insert into member (member_id, password, name, phone, email, address, birthday) "
			+ "values (#{memberId}, #{password}, #{name}, #{phone}, #{email}, "
			+ "#{address}, #{birthday, jdbcType=DATE})")
	int insertMember(MemberCreateDto member);

	@Update("update member set name = #{name}, password = #{password}, email = #{email} where member_id = #{memberId}")
	int updateMember(Member member);

	@Delete("delete from member where member_id = #{memberId}")
	int deleteMember(String memberId);

	MemberDetails loadUserByUsername(String username);

	@Insert("insert into member values (#{memberId}, #{password}, #{name}, #{birthday, jdbcType=DATE}, #{email, jdbcType=VARCHAR}, default)")
	int insertMember(KakaoMemberCreateDto member);

}
