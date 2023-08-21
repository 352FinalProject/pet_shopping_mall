package com.shop.app.servicecenter.chat.service;

import java.util.List;

import com.shop.app.servicecenter.chat.entity.Chat;
import com.shop.app.servicecenter.chat.entity.ChatRoom;

public interface ChatService {

	List<ChatRoom> findAllRoom();
}
