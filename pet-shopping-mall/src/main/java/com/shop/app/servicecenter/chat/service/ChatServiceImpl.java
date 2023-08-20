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
	public List<ChatRoom> findAllRoom() {
		// TODO Auto-generated method stub
		return null;
	}

}
