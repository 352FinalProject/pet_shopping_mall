package com.shop.app.servicecenter.chat.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.shop.app.product.service.ProductService;
import com.shop.app.servicecenter.chat.dto.ChatSession;
import com.shop.app.servicecenter.chat.entity.Chat;
import com.shop.app.servicecenter.chat.entity.ChatRoom;
import com.shop.app.servicecenter.chat.service.ChatService;

@Controller
public class ChatController {

	@Autowired
	ChatService cService;

	@Autowired
	ProductService pService;

	@Autowired
	private ChatSession cSession;
	
	@GetMapping("/servicecenter/chat/chat.do")
	public void chatList() {
	}

	/**
	 * 해당 채팅방의 채팅 메세지 불러오기
	 * @param roomId
	 * @param model
	 * @param response
	 * @throws JsonIOException
	 * @throws IOException
	 */
	@RequestMapping(value="{roomId}.do")
	public void messageList(@PathVariable String chatRoomId, Model model, HttpServletResponse response) throws JsonIOException, IOException {

		List<Chat> mList = cService.messageList(chatRoomId);
		response.setContentType("application/json; charset=utf-8");

		// 안읽은 메세지의 숫자 0으로 바뀌기
		Chat message = new Chat();
		message.setChatRoomId(chatRoomId);
		int result = cService.updateCount(message);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(mList,response.getWriter());
	}

	/**
	 * 채팅 방이 없을 때 생성
	 * @param room
	 * @param userEmail
	 * @param masterNickname
	 * @return
	 */
	@ResponseBody
	@RequestMapping("createChat.do")
	public String createChat(ChatRoom chatRoom, String chatRoomMemberId, String chatRoomAdminRoll, String masterNickname){

		chatRoom.setChatRoomMemberId(chatRoomMemberId);
		chatRoom.setChatRoomAdminRoll(chatRoomAdminRoll);

		ChatRoom exist  = cService.searchChatRoom(chatRoom);

		// DB에 방이 없을 때
		if(exist == null) {
			System.out.println("방이 없다!!");
			int result = cService.createChat(chatRoom);
			if(result == 1) {
				System.out.println("방 만들었다!!");
				return "new";
			}else {
				return "fail";
			}
		}
		// DB에 방이 있을 때
		else{
			System.out.println("방이 있다!!");
			return "exist";
		}
	}

	/**
	 * 채팅 방 목록 불러오기
	 * @param room
	 * @param userEmail
	 * @param response
	 * @throws JsonIOException
	 * @throws IOException
	 */
	@RequestMapping("chatRoomList.do")
	public void createChat(ChatRoom chatRoom, int chatRoomId,Chat message, HttpServletResponse response) throws JsonIOException, IOException{
		List<ChatRoom> cList = cService.chatRoomList(chatRoomId);

		for(int i = 0; i < cList.size(); i++) {
			message.setChatRoomId(cList.get(i).getChatRoomId());
			int count = cService.selectUnReadCount(message);
			cList.get(i).setChatUnReadCount(count);
		}

		response.setContentType("application/json; charset=utf-8");

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(cList,response.getWriter());
	}

	@RequestMapping("chatSession.do")
	public void chatSession( HttpServletResponse response) throws JsonIOException, IOException{

		ArrayList<String> chatSessionList = cSession.getLoginChatMember();

		response.setContentType("application/json; charset=utf-8");

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(chatSessionList,response.getWriter());
	}

}
