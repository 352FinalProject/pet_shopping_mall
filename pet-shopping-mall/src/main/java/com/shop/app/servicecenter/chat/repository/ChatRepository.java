package com.shop.app.servicecenter.chat.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.shop.app.servicecenter.chat.entity.Chat;
import com.shop.app.servicecenter.chat.entity.ChatRoom;

@Mapper
public interface ChatRepository {
	
    public static final SqlSessionTemplate sqlSession = null;

    
	public ChatRoom selectChatRoom(String chatRoomId);

	public int insertMessage(Chat chatMessage);

	public List<Chat> messageList(String chatRoomId);

	public int createChat(ChatRoom chatRoom);

	public ChatRoom searchChatRoom(ChatRoom chatRoom);

	public List<ChatRoom> chatRoomList(int chatRoomId);

	public int selectUnReadCount(Chat message);

}
