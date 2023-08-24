package com.shop.app.member.dto;

import java.util.List;

import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.entity.Order;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MypageDto {
	private String memberId;
	private String name;
	private String subscribe; // N: 구독안함 / Y: 구독함
	private int pointCurrent;
	private List<Order> orderHistory; // 최근주문내역
}
