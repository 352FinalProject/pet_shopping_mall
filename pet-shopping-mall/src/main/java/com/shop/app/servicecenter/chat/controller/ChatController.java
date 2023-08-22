//package com.shop.app.servicecenter.chat.controller;
//
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.messaging.handler.annotation.DestinationVariable;
//import org.springframework.messaging.handler.annotation.MessageMapping;
//import org.springframework.messaging.handler.annotation.Payload;
//import org.springframework.messaging.handler.annotation.SendTo;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import com.shop.app.servicecenter.chat.entity.Chat;
//import com.shop.app.servicecenter.chat.entity.ChatRoom;
//import com.shop.app.servicecenter.chat.service.ChatService;
//
//@Controller
//@RequestMapping("/servicecenter/chat")
//public class ChatController {
//	
//	@Autowired
//	private ChatService chatService;
//	
//    @GetMapping("/chat.do")
//    public String showChatPage(Model model) {
//        return "servicecenter/chat/chat";
//    }
//    
//    // 채팅방 리스트 반환
//    @GetMapping("/rooms")
//    public String roomList(Model model) {
//        List<ChatRoom> rooms = chatService.findAllRoom();
//        model.addAttribute("rooms", rooms);
//        return "servicecenter/chat/roomList";
//    }
//
//    // 특정 채팅방으로 이동
//    @GetMapping("/rooms/{roomId}")
//    public String room(@PathVariable String roomId, Model model) {
//        model.addAttribute("roomId", roomId);
//        return "servicecenter/chat/chat";
//    }
//    
//    // 메세지를 전송/수신하는 메소드
//    @MessageMapping("/chat/{roomId}/sendMessage")
//    @SendTo("/queue/{roomId}")
//    public Chat sendMessage(@DestinationVariable String roomId, @Payload Chat chatMessage) {
//        return chatMessage;
//    }
//}
