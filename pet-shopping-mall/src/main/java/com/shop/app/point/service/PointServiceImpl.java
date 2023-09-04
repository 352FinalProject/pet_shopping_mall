package com.shop.app.point.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
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
	public List<Point> findPointAll(Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return pointRepository.findPointAll(rowBounds);
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

	// 물건 구매 포인트 사용 (예라)
	@Override
	public int insertUsedPoint(Point usedPoint) {
		return pointRepository.insertUsedPoint(usedPoint);
	}

	// 취소된 포인트를 db에 저장 (예라)
	@Override
	public int insertRollbackPoint(Point rollbackPoint) {
		return pointRepository.insertRollbackPoint(rollbackPoint);
	}

	// 삭제된 리뷰에 대한 포인트 정보 가져오기 (예라)
	@Override
	public Point getPointByReviewId(int reviewId) {
		return pointRepository.getPointByReviewId(reviewId);
	}

	// 포인트 롤백
	@Override
	public List<Point> findRollbackPointCurrentById(Point rollbackPoint) {
		return pointRepository.findRollbackPointCurrentById(rollbackPoint);
	}

	@Override
	public int findTotalPointCount() {
		return pointRepository.findTotalPointCount();
	}
}
