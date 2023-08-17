package com.shop.app.servicecenter.chat.dto;

import java.util.ArrayList;

import org.springframework.stereotype.Component;

/**
 * 현재 로그인 되어 있는 유저들을 저장하는 VO
 * DB 저장 X / 온라인 오프라인 확인용
 */
@Component("cSession")
public class ChatSession {

 
    // static으로 필드변수를 설정하여 같은 ArrayList를 이용 할 수 있도록 선언
    private static ArrayList<String> loginUser = new ArrayList<String>();
    
    // 로그인 시 ArrayList에 추가합니다.
    public void addLoginUser(String email) {
        loginUser.add(email);
    }
    
    // 로그아웃 시 ArrayList에서 제거
    public void removeLoginUser(String email) {
        loginUser.remove(email);
    }
 
    // 현재 로그인 되어 있는 유저 목록을 가져온다
    public static ArrayList<String> getLoginUser() {
        return loginUser;
    }
 
    // 자동 setter. 사용
    public static void setLoginUser(ArrayList<String> loginUser) {
        ChatSession.loginUser = loginUser;
    }
}
