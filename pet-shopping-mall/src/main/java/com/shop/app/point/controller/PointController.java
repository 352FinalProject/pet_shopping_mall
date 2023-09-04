package com.shop.app.point.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public void pointList (@RequestParam(defaultValue = "1") int page, Point point, Model model) {
		int limit = 5;
		
		Map<String, Object> params = Map.of(
				"page", page,
				"limit", limit
			);
		
		int totalCount = pointService.findTotalPointCount();
		int totalPages = (int) Math.ceil((double) totalCount / limit);
		model.addAttribute("totalPages", totalPages);
		
		List<Point> points = pointService.findPointAll(params);
		
		model.addAttribute("points", points);
		
	}
}
