package com.shop.app.point.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.shop.app.point.entity.Point;
import com.shop.app.review.entity.ReviewDetails;

@Mapper
public interface PointRepository {

	@Select("select * from point where point_member_id = #{pointMemberId}")
	List<Point> findPointAll(RowBounds rowBounds, String pointMemberId);

	@Insert("insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date, review_id) values (seq_point_id.nextval, #{pointMemberId}, #{pointCurrent}, #{pointType}, #{pointAmount}, default, #{reviewId})")
	int insertPoint(Point point);
	
	@Results({
	    @Result(property = "pointMemberId", column = "review_member_id")})
	@Select("select * from (select * from review where review_member_id = #{reviewMemberId} order by review_created_at desc) where rownum <= 1")
	Point findReviewPointMemberById(ReviewDetails reviews);

	@Select("select * from (select * from point where point_member_id = #{pointMemberId} order by point_date desc) where rownum <= 1")
	Point findReviewPointCurrentById(Point point);

	@Select("select * from (select * from point where point_member_id = #{member_id} order by point_date desc) where rownum <= 1")
	Point findCurrentPointById(String memberId);

	@Select("select * from (select * from point where point_member_id = #{pointMemberId} order by point_date desc) where rownum <= 1")
	Point findPointCurrentById(Point points);

	@Insert("insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date) values (seq_point_id.nextval, #{pointMemberId}, #{pointCurrent}, #{pointType}, #{pointAmount}, default)")
	int insertUsedPoint(Point usedPoint);

	@Insert("insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date) values (seq_point_id.nextval, #{pointMemberId}, #{pointCurrent}, #{pointType}, #{pointAmount}, default)")
	int insertRollbackPoint(Point rollbackPoint);

	@Select("select * from point where review_id = #{reviewId}")
	Point getPointByReviewId(int reviewId);

	@Select("select * from point where point_member_id = #{pointMemberId} order by point_date desc")
	List<Point> findRollbackPointCurrentById(Point rollbackPoint);

	@Select("select count (*) from point where point_member_id = #{pointMemberId}")
	int findTotalPointCount(String pointMemberId);




}
