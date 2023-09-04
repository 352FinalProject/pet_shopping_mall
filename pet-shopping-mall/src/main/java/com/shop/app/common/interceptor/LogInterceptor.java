package com.shop.app.common.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

/**
 * HandlerInterceptor
 * 
 * - preHandle : HandlerAdapter를 통한 controller 호출전. 컨트롤러 공통코드 구현(인증)
 * - postHandle : HandlerAdapter를 통한 controller 호출후. 핸들러 반환값에 대한 전처리.
 * - afterCompletion : view단 처리후. 응답처리관련 공통코드
 * 
 *
 */
@Slf4j
public class LogInterceptor implements HandlerInterceptor {
	
	/**
	 * preHandle의 리턴값 boolean
	 * - true 이후 핸들러 코드 정상호출.
	 * - false 핸들러코드 호출없이 afterCompletion 호출.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView mav) throws Exception {
		
		if(mav != null) {
			Map<String, Object> model = mav.getModel();
			String viewName = mav.getViewName();
		}
		
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
