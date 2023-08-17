package com.shop.app.point.service;

import java.util.List;

import com.shop.app.point.entity.Point;
import com.shop.app.review.entity.ReviewDetails;

public interface PointService	 {

	// 포인트 전체 조회 (예라)
	List<Point> findPointAll(Point point);

	// 회원가입 포인트 적립 (예라)
	int insertPoint(Point point);

	// 리뷰 쓴 사용자 포인트 적립을 위해 아이디 조회 (예라)
	Point findReviewPointMemberById(ReviewDetails reviews);

	
}

