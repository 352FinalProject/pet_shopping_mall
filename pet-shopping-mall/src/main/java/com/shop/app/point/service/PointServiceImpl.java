package com.shop.app.point.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.point.entity.Point;
import com.shop.app.point.repository.PointRepository;

@Service
public class PointServiceImpl implements PointService {

	@Autowired
	private PointRepository pointRepository;
	
	@Override
	public List<Point> findPointAll(Point point) {
		return pointRepository.findPointAll(point);
	}

}
