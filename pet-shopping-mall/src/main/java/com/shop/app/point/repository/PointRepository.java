package com.shop.app.point.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.point.entity.Point;
import com.shop.app.review.entity.ReviewDetails;

@Mapper
public interface PointRepository {

	// 포인트 전체 조회 (예라)
	@Select("select * from point order by point_id desc")
	List<Point> findPointAll(Point point);

	// 포인트 적립 (예라)
	@Insert("insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date) values (seq_point_id.nextval, #{pointMemberId}, #{pointCurrent}, #{pointType}, #{pointAmount}, default)")
	int insertPoint(Point point);
	
	// 리뷰 쓴 사용자 포인트 적립을 위해 아이디 조회 (예라)
	@Results({
	    @Result(property = "pointMemberId", column = "review_member_id")})
	@Select("select * from (select * from review where review_member_id = #{reviewMemberId} order by review_created_at desc) where rownum <= 1")
	Point findReviewPointMemberById(ReviewDetails reviews);
	
	// 리뷰, 구매 적립 memberId값으로 현재 사용자의 포인트 가져오기 (예라)
	@Select("select * from (select * from point where point_member_id = #{pointMemberId} order by point_date desc) where rownum <= 1")
	Point findReviewPointCurrentById(Point point);

	// 멤버아이디로 포인트 조회 (담희)
	@Select("select * from point where point_member_id = #{member_id}")
	Point findCurrentPointById(String memberId);

	// (사용) 사용자의 현재 포인트를 가져오기 (예라)
	@Select("select * from (select * from point where point_member_id = #{pointMemberId} order by point_date desc) where rownum <= 1")
	Point findPointCurrentById(Point points);

	// 물건 구매 포인트 사용 (예라)
	@Insert("insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date) values (seq_point_id.nextval, #{pointMemberId}, #{pointCurrent}, #{pointType}, #{pointAmount}, default)")
	int insertUsedPoint(Point usedPoint);


}
