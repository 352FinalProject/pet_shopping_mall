package com.shop.app.servicecenter.chat.controller;

import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shop.app.servicecenter.chat.entity.Chat;
import com.shop.app.servicecenter.chat.entity.ChatRoom;
import com.shop.app.servicecenter.chat.service.ChatService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class WebSocketHandler extends TextWebSocketHandler implements InitializingBean {

	@Autowired
	ChatService cService;

	private final ObjectMapper objectMapper = new ObjectMapper();

	// 채팅방 목록 <방 번호, ArrayList<session> >이 들어간다.
	private Map<String, ArrayList<WebSocketSession>> RoomList = new ConcurrentHashMap<String, ArrayList<WebSocketSession>>();
	// session, 방 번호가 들어간다.
	private Map<WebSocketSession, String> sessionList = new ConcurrentHashMap<WebSocketSession, String>();

	private static int i;
	/**
	 * websocket 연결 성공 시
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		i++;
		System.out.println(session.getId() + " 연결 성공 => 총 접속 인원 : " + i + "명");
	}

	/**
	 * websocket 연결 종료 시
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		i--;
		System.out.println(session.getId() + " 연결 종료 => 총 접속 인원 : " + i + "명");
		// sessionList에 session이 있다면
		if(sessionList.get(session) != null) {
			// 해당 session의 방 번호를 가져와서, 방을 찾고, 그 방의 ArrayList<session>에서 해당 session을 지운다.
			RoomList.get(sessionList.get(session)).remove(session);
			sessionList.remove(session);
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		// 전달받은 메세지
		String msg = message.getPayload();

		// Json객체 → Java객체
		// 출력값 : [roomId=123, messageId=null, message=asd, name=천동민, email=cheon@gmail.com, unReadCount=0]
		Chat chatMessage = objectMapper.readValue(msg,Chat.class);

		// 받은 메세지에 담긴 roomId로 해당 채팅방을 찾아온다.
		ChatRoom chatRoom = cService.selectChatRoom(chatMessage.getChatRoomId());

		// 채팅 세션 목록에 채팅방이 존재하지 않고, 처음 들어왔고, DB에서의 채팅방이 있을 때
		// 채팅방 생성
		if(RoomList.get(chatRoom.getChatRoomId()) == null && chatMessage.getChatMessage().equals("ENTER-CHAT") && chatRoom != null) {

			// 채팅방에 들어갈 session들
			ArrayList<WebSocketSession> sessionTwo = new ArrayList<>();
			// session 추가
			sessionTwo.add(session);
			// sessionList에 추가
			sessionList.put(session, chatRoom.getChatRoomId());
			// RoomList에 추가
			RoomList.put(chatRoom.getChatRoomId(), sessionTwo);
			// 확인용
			System.out.println("채팅방 생성");
		}

		// 채팅방이 존재 할 때
		else if(RoomList.get(chatRoom.getChatRoomId()) != null && chatMessage.getChatMessage().equals("ENTER-CHAT") && chatRoom != null) {

			// RoomList에서 해당 방번호를 가진 방이 있는지 확인.
			RoomList.get(chatRoom.getChatRoomId()).add(session);
			// sessionList에 추가
			sessionList.put(session, chatRoom.getChatRoomId());
			// 확인용
			System.out.println("생성된 채팅방으로 입장");
		}

		// 채팅 메세지 입력 시
		else if(RoomList.get(chatRoom.getChatRoomId()) != null && !chatMessage.getChatMessage().equals("ENTER-CHAT") && chatRoom != null) {

			// 메세지에 아이디 내용을 담는다.
			TextMessage textMessage = new TextMessage(chatMessage.getChatMemberId() + "," + chatMessage.getChatMessage());

			// 현재 session 수
			int sessionCount = 0;

			// 해당 채팅방의 session에 뿌려준다.
			for(WebSocketSession sess : RoomList.get(chatRoom.getChatRoomId())) {
				sess.sendMessage(textMessage);
				sessionCount++;
			}

			// 동적쿼리에서 사용할 sessionCount 저장
			// sessionCount == 2 일 때는 unReadCount = 0,
			// sessionCount == 1 일 때는 unReadCount = 1
			chatMessage.setChatSessionCount(sessionCount);

			// DB에 저장한다.
			int a = cService.insertMessage(chatMessage);

			if(a == 1) {
				System.out.println("메세지 전송 및 DB 저장 성공");
			}else {
				System.out.println("메세지 전송 실패!!! & DB 저장 실패!!");
			}
		}
	}

	@Override
	public void afterPropertiesSet() throws Exception {}
}
