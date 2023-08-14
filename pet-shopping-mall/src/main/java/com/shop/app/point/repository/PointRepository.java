package com.shop.app.point.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.point.entity.Point;

@Mapper
public interface PointRepository {

	// 포인트 전체 조회 (예라)
	@Select("select * from point order by point_id desc")
	List<Point> findPointAll(Point point);

	// 회원가입 포인트 저장 (예라)
	@Insert("insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date) values (seq_point_point_id.nextval, #{pointMemberId}, #{pointCurrent}, #{pointType}, #{pointAmount}, default)")
	int givePointsForSignUp(Point point);

}
