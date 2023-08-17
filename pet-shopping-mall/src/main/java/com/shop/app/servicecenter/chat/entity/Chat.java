package com.shop.app.servicecenter.chat.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Chat {
	
	private int chatId; // 채팅 참여자 고유 아이디
	private int chatRoomId; // 채팅방 아이디
	private String chatMemberId; // 채팅 참여자 아이디
	private String chatMessage; // 채팅 메세지
	private LocalDateTime chatCreatedAt; // 채팅을 보낸 날짜와 시간
	
}
