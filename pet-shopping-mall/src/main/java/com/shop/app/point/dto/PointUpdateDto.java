package com.shop.app.point.dto;


import java.time.LocalDateTime;

import com.shop.app.point.entity.Point;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PointUpdateDto {
	private Integer pointId;
	private String pointMemberId;
	private String pointType;
	private Integer pointAmount;
	private Integer pointCurrent;
	private LocalDateTime pointDate;
	
	public Point toPoint() {
		return Point.builder()
				.pointId(pointId)
				.pointMemberId(pointMemberId)
				.pointType(pointType)
				.pointAmount(pointAmount)
				.pointCurrent(pointCurrent)
				.pointDate(pointDate)
				.build();
	}
}
