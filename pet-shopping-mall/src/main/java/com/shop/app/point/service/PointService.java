package com.shop.app.point.service;

import java.util.List;
import java.util.Map;

import com.shop.app.order.entity.OrderDetail;
import com.shop.app.point.entity.Point;
import com.shop.app.review.entity.ReviewDetails;

public interface PointService	 {

	List<Point> findPointAll(Map<String, Object> params, String pointMemberId);

	int insertPoint(Point point);
	
	Point findCurrentPointById(String memberId);

	Point findReviewPointCurrentById(Point point);
	
	Point findPointCurrentById(Point points);

	int insertUsedPoint(Point usedPoint);

	int insertRollbackPoint(Point rollbackPoint);

	Point getPointByReviewId(int reviewId);

	List<Point> findRollbackPointCurrentById(Point rollbackPoint);

	int findTotalPointCount(String pointMemberId);

	
}

