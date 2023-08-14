package com.shop.app.member.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.security.core.userdetails.UserDetails;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;
@Mapper
public interface MemberRepository {
	
	@Select("select * from member where member_id = #{memberId}")
	Member findMemberById(String memberId);
	
	@Insert("insert into member values ()")
	int insertMember(MemberCreateDto member);
	
	@Update("update member set birthday =")
	int updateMember(Member member);

	@Delete("delete from member where member_id= #{memberId}")
	int deleteMember(Member member);


	MemberDetails loadUserByUsername(String username);

}
