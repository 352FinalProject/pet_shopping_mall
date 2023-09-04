package com.shop.app.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;

import com.shop.app.member.entity.MemberDetails;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthNullCheckInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		SecurityContext securityContext = SecurityContextHolder.getContext();
		Authentication authentication = securityContext.getAuthentication();
		Object principal = authentication.getPrincipal();
		if(principal instanceof MemberDetails) {
			MemberDetails member = (MemberDetails) principal;
			if(member.getMemberId() == null) {
				response.sendRedirect(request.getContextPath() + "/member/memberLogin.do");
				return false; // handler호출 없이 afterCompletion처리후 응답.
			}
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
