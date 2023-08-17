package com.shop.app.servicecenter.chat.entity;

import java.time.LocalDateTime;

public class ChatRoom {

	private int chatRoomId; // 채팅방 아이디
	private String chatRoomMemberId; // 채팅방 멤버 아이디
	private String chatRoomAdminRoll; // 채팅방 관리자 롤
	private int chatRoomUnReadCount; // 채팅방 안 읽은 메세지
	private LocalDateTime chatRoomCreatedAt; // 채팅방 생성일
	
}
