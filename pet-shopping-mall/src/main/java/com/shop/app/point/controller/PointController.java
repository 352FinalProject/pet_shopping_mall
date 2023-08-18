package com.shop.app.point.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/point")
@Slf4j
public class PointController {

	@Autowired
	private PointService pointService;
	
	// 포인트 전체 조회 (예라)
	@GetMapping("/pointList.do")
	public void pointList (Point point, Model model) {
		List<Point> points = pointService.findPointAll(point);
		
		model.addAttribute("points", points);
		
	}
}
