package com.shop.app.point.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Point {
	private int pointId;
	private String pointMemberId;
	private String pointType;
	private int pointAmount;
	private int pointCurrent;
	private LocalDateTime pointDate;
	private int reviewId;
}
