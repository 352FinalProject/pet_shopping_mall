package com.shop.app.config;


import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker // Socket과 STOMP관련 설정
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer{
	
	/**
	 * @author 김대원
	 * 소켓 연결과 관련된 설정
	 */
	@Override 
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/stomp") // 소켓 연결 uri
				.withSockJS(); // 웹소켓 미지원 브라우져를 위한 설정
	}
	
	/**
	 * @author 김대원
	 * Stomp 사용을 위한 Message Broker 설정을 해주는 메소드
	 */
	@Override 
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		// 1. simpleBroker로 처리하는 url 등록. 메세지를 받을 때, 경로를 설정
		registry.enableSimpleBroker("/pet");
		
		// 2. MessageHandler로 처리하는 url 등록. 메세지를 보낼 때, 경로를 설정
		registry.setApplicationDestinationPrefixes("/pet");
		
		
	}
	
	
	
}
