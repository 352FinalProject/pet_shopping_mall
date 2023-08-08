package com.shop.app.member.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.member.dto.MemberCreateDto;
import com.shop.app.member.entity.Member;
@Mapper
public interface MemberRepository {
	
	@Select("select * from member where member_id = #{memberId}")
	Member findMemberById(String memberId);
	
	@Insert("insert into member values ()")
	int insertMember(MemberCreateDto member);
	
	@Update("update member set birthday =")
	int updateMember(Member member);
	
	@Delete("delete memeber where id = #{memberId}")
	int deleteMember(Member member);

}
