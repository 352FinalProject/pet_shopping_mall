package com.shop.app.servicecenter.chat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.servicecenter.chat.entity.Chat;
import com.shop.app.servicecenter.chat.entity.ChatRoom;
import com.shop.app.servicecenter.chat.repository.ChatRepository;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatRepository chatRepository;

	@Override
	public ChatRoom selectChatRoom(String chatRoomId) {
		return chatRepository.selectChatRoom(chatRoomId);
	}

	@Override
	public int insertMessage(Chat chatMessage) {
		return chatRepository.insertMessage(chatMessage);
	}

	@Override
	public List<Chat> messageList(String chatRoomId) {
		return chatRepository.messageList(chatRoomId);
	}

	@Override
	public int createChat(ChatRoom chatRoom) {
		return chatRepository.createChat(chatRoom);
	}

	@Override
	public ChatRoom searchChatRoom(ChatRoom chatRoom) {
		return chatRepository.searchChatRoom(chatRoom);
	}

	@Override
	public List<ChatRoom> chatRoomList(int chatRoomId) {
		return chatRepository.chatRoomList(chatRoomId);
	}

	@Override
	public int selectUnReadCount(Chat message) {
		return chatRepository.selectUnReadCount(message);
	}

	@Override
	public int updateCount(Chat message) {
		return chatRepository.selectUnReadCount(message);
	}

}
