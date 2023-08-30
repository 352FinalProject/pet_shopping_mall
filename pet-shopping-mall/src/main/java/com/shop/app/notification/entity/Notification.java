package com.shop.app.notification.entity;

import java.sql.Timestamp;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Notification {
	private int id;
	private int notiCategory; // 1.주문알림 2.구독알림 3.기타알림
	private String notiContent;
	private String notiCreatedAt;
	private String memberId;

}