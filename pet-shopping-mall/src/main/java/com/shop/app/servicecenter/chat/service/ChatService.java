package com.shop.app.servicecenter.chat.service;

import java.util.List;

import com.shop.app.servicecenter.chat.entity.Chat;
import com.shop.app.servicecenter.chat.entity.ChatRoom;

public interface ChatService {

	
    /**
     * 방 번호를 선택하는 메소드
     * @param roomId
     * @return
     */
    // ChatRoom selectChatRoom(String string);
	ChatRoom selectChatRoom(String chatRoomId);
 
    /**
     * 채팅 메세지 DB 저장
     * @param chatMessage
     * @return 
     */
    // int insertMessage(Chat chatMessage);
	int insertMessage(Chat chatMessage);
 
    /**
     * 메세지 내용 리스트 출력
     * @param roomId
     * @return
     */
    // List<Chat> messageList(String chatRoomId);
	List<Chat> messageList(String chatRoomId);
 
    /**
     * 채팅 방 DB 저장
     * @param room
     * @return
     */
    // int createChat(ChatRoom chatRoom);
	int createChat(ChatRoom chatRoom);
 
    /**
     * DB에 채팅 방이 있는지 확인
     * @param room
     * @return
     */
    // ChatRoom searchChatRoom(ChatRoom chatRoom);
	ChatRoom searchChatRoom(ChatRoom chatRoom);
 
    /**
     * 채팅 방 리스트 출력
     * @param chatRoomId
     * @return
     */
    // List<ChatRoom> chatRoomList(int chatRoomId);
	List<ChatRoom> chatRoomList(int chatRoomId);
 
    /**
     * 채팅 읽지 않은 메세지 수 출력
     * @param message
     * @return
     */
    // int selectUnReadCount(Chat CHATmessage);
	int selectUnReadCount(Chat message);
 
    /**
     * 읽은 메세지 숫자 0으로 바꾸기
     * @param message
     * @return
     */
	int updateCount(Chat message);
}
