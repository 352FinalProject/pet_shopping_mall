package com.shop.app.point.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.point.entity.Point;
import com.shop.app.point.repository.PointRepository;
import com.shop.app.review.entity.ReviewDetails;

@Service
public class PointServiceImpl implements PointService {

	@Autowired
	private PointRepository pointRepository;
	
	@Override
	public List<Point> findPointAll(Point point) {
		return pointRepository.findPointAll(point);
	}

	// 회원가입 포인트 적립 (예라)
	@Override
	public int insertPoint(Point point) {
		return pointRepository.insertPoint(point);
	}


	// 멤버아이디로 포인트 조회 (담희)
	@Override
	public Point findCurrentPointById(String memberId) {
		return pointRepository.findCurrentPointById(memberId);
	}


	// 리뷰 쓴 사용자 포인트 적립을 위해 아이디 조회 (예라)
	@Override
	public Point findReviewPointMemberById(ReviewDetails reviews) {
		return pointRepository.findReviewPointMemberById(reviews);
	}
	
	// 리뷰 포인트 적립 (예라)
	@Override
	public int updatePoint(Point point) {
		return pointRepository.updatePoint(point);
	}


}
