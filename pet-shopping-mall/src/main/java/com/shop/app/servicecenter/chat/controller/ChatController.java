//package com.shop.app.servicecenter.chat.controller;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//import com.google.gson.JsonIOException;
//import com.shop.app.product.service.ProductService;
//import com.shop.app.servicecenter.chat.entity.ChatRoom;
//import com.shop.app.servicecenter.chat.service.ChatService;
//
//@Controller
//public class ChatController {
//
//	@Autowired
//	ChatService cService;
//
//	@Autowired
//	ProductService pService;
//
//	@Autowired
//	private ChatSession cSession;
//
//	/**
//	 * 해당 채팅방의 채팅 메세지 불러오기
//	 * @param roomId
//	 * @param model
//	 * @param response
//	 * @throws JsonIOException
//	 * @throws IOException
//	 */
//	@RequestMapping(value="{roomId}.do")
//	public void messageList(@PathVariable String roomId, String userEmail, Model model, HttpServletResponse response) throws JsonIOException, IOException {
//
//		List<ChatMessage> mList = cService.messageList(roomId);
//		response.setContentType("application/json; charset=utf-8");
//
//		// 안읽은 메세지의 숫자 0으로 바뀌기
//		ChatMessage message = new ChatMessage();
//		message.setEmail(userEmail);
//		message.setRoomId(roomId);
//		cService.updateCount(message);
//
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
//		gson.toJson(mList,response.getWriter());
//	}
//
//	/**
//	 * 채팅 방이 없을 때 생성
//	 * @param room
//	 * @param userEmail
//	 * @param masterNickname
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping("createChat.do")
//	public String createChat(ChatRoom room, String userName, String userEmail, String masterNickname){
//
//		UserMaster m = pService.getProductDetail(masterNickname);
//
//		room.setUserEmail(userEmail);
//		room.setUserName(userName);
//		room.setMasterEmail(m.getEmail());
//		room.setMasterName(m.getmNickname());
//		room.setMasterPic(m.getmProPicRe());
//
//		ChatRoom exist  = cService.searchChatRoom(room);
//
//		// DB에 방이 없을 때
//		if(exist == null) {
//			System.out.println("방이 없다!!");
//			int result = cService.createChat(room);
//			if(result == 1) {
//				System.out.println("방 만들었다!!");
//				return "new";
//			}else {
//				return "fail";
//			}
//		}
//		// DB에 방이 있을 때
//		else{
//			System.out.println("방이 있다!!");
//			return "exist";
//		}
//	}
//
//	/**
//	 * 채팅 방 목록 불러오기
//	 * @param room
//	 * @param userEmail
//	 * @param response
//	 * @throws JsonIOException
//	 * @throws IOException
//	 */
//	@RequestMapping("chatRoomList.do")
//	public void createChat(ChatRoom room, ChatMessage message, String userEmail, HttpServletResponse response) throws JsonIOException, IOException{
//		List<ChatRoom> cList = cService.chatRoomList(userEmail);
//
//		for(int i = 0; i < cList.size(); i++) {
//			message.setRoomId(cList.get(i).getRoomId());
//			message.setEmail(userEmail);
//			int count = cService.selectUnReadCount(message);
//			cList.get(i).setUnReadCount(count);
//		}
//
//		response.setContentType("application/json; charset=utf-8");
//
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
//		gson.toJson(cList,response.getWriter());
//	}
//
//	@RequestMapping("chatSession.do")
//	public void chatSession( HttpServletResponse response) throws JsonIOException, IOException{
//
//		ArrayList<String> chatSessionList = cSession.getLoginUser();
//
//		response.setContentType("application/json; charset=utf-8");
//
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
//		gson.toJson(chatSessionList,response.getWriter());
//	}
//
//}
