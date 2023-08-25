package com.shop.app.ws.dto;

import java.sql.Timestamp;

import com.shop.app.member.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Payload {
	private int id;
	private int notiCategory; // 0.공지사항 1.주문알림 2.구독알림 3.기타알림
	private String notiContent;
	private Timestamp notiCreatedAt;
	private Member memberId;
}