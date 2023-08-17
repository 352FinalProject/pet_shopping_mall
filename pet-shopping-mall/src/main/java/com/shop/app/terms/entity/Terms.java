package com.shop.app.terms.entity;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import com.shop.app.point.entity.Point;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Terms {

	private int historyId;
	private int termsId;
	private String memberId;
	private Accept accept;
	private Timestamp acceptDate;
}
