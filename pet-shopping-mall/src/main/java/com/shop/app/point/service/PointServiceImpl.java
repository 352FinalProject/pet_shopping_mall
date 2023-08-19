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

	// 리뷰, 구매 적립 memberId값으로 현재 사용자의 포인트 가져오기 (예라)
	@Override
	public Point findReviewPointCurrentById(Point point) {
		return pointRepository.findReviewPointCurrentById(point);
	}

	// (사용) 사용자의 현재 포인트를 가져오기 (예라)
	@Override
	public Point findPointCurrentById(Point points) {
		return pointRepository.findPointCurrentById(points);
	}
}
