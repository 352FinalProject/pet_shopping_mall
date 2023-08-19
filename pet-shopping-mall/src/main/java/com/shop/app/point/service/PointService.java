package com.shop.app.point.service;

import java.util.List;

import com.shop.app.point.entity.Point;
import com.shop.app.review.entity.ReviewDetails;

public interface PointService	 {

	// 포인트 전체 조회 (예라)
	List<Point> findPointAll(Point point);

	// 회원가입 포인트 적립 (예라)
	int insertPoint(Point point);
	
	// 멤버아이디로 포인트 조회 (담희)
	Point findCurrentPointById(String memberId);
	
	// 리뷰, 구매 적립 memberId값으로 현재 사용자의 포인트 가져오기 (예라)
	Point findReviewPointCurrentById(Point point);

	// (사용) 사용자의 현재 포인트를 가져오기 (예라)
	Point findPointCurrentById(Point points);

	
}

