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
import com.shop.app.member.entity.SubMember;

@Mapper
public interface MemberRepository {


	@Select("select * from member where member_id = #{memberId}")
	Member findMemberById(String memberId);

	@Insert("INSERT INTO member VALUES (#{memberId, jdbcType=VARCHAR}, #{password}, #{name, jdbcType=VARCHAR}, #{phone, jdbcType=VARCHAR}, #{email, jdbcType=VARCHAR}, default, #{address, jdbcType=VARCHAR}, #{birthday, jdbcType=DATE}, default)")
	int insertMember(MemberCreateDto member);

	@Update("update member set name = #{name}, password = #{password}, email = #{email}, address=#{address}, phone = #{phone, jdbcType=VARCHAR} where member_id = #{memberId}")
	int updateMember(Member member);

	@Delete("delete from member where member_id = #{memberId}")
	int deleteMember(String memberId);

	MemberDetails loadUserByUsername(String username);
	
	@Select("select * from member where email=#{email}")
	Member findByEmail(String email);

	@Select("select * from member where birthday = #{birthday}")
	List<Member> findBirthdayMember();

	@Select("select * from member Where to_char(birthday, 'MM') = to_char(SYSDATE, 'MM')")
	List<Member> findThisMonthBirthdayMembers(int currentMonth);

	MypageDto getMyPage(String memberId);
	
	@Update("update member set subscribe = 'Y' where member_id = #{memberId}")
	int memberSubscribe(String memberId);

	@Update("update member set subscribe = 'N' where member_id = #{memberId}")
	int subscribeCancel(String memberId);

	@Insert("insert into sub_member (subscribe_id, member_id, merchant_uid, schedule_at, schedule_status, amount) values(seq_subscribe_id.nextVal, #{memberId}, #{merchantUid, jdbcType=VARCHAR}, #{scheduleAt, jdbcType=DATE}, #{scheduleStatus, jdbcType=VARCHAR}, #{amount, jdbcType=INTEGER})")
	int insertSubMember(SubMember subMember);

	@Select("select * from sub_member where member_id = #{memberId} order by  schedule_at desc fetch first 1 row only")
	SubMember findSubMemberByMemberId(String memberId);

	@Update("update sub_member set schedule_status = 'cancel' where member_id = #{memberId}")
	int cancelSubscribe(String memberId);

	@Select("select * from sub_member where schedule_status = 'cancel' and trunc(schedule_at) <= trunc(sysdate)")
	List<SubMember> updateCancelSubscribers();

	
}
