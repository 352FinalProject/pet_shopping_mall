package com.shop.app.point.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.point.entity.Point;

@Mapper
public interface PointRepository {

	// 포인트 전체 조회 (예라)
	@Select("select * from point order by point_id desc")
	List<Point> findPointAll(Point point);

}
