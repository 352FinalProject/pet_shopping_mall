package com.shop.app.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.shop.app.common.interceptor.AuthNullCheckInterceptor;
import com.shop.app.common.interceptor.LogInterceptor;

// 웹 MVC 설정 클래스 선언
@Configuration
public class AppConfig implements WebMvcConfigurer {
	
	// 인터셉터를 등록하는 메서드
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// 로그 인터셉터 등록
		// 모든 경로("/**")에 대해서 적용되며, 리소스 경로("/resources/**")는 제외됩니다.
		registry.addInterceptor(new LogInterceptor())
				.addPathPatterns("/**")
				.excludePathPatterns("/resources/**");

		// 권한 및 널 체크 인터셉터 등록
		// 모든 경로("/**")에 대해서 적용되며, 리소스 경로("/resources/**")와 로그인 경로("/member/memberLogin.do")는 제외됩니다.
		registry.addInterceptor(new AuthNullCheckInterceptor())
				.addPathPatterns("/**")
				.excludePathPatterns("/resources/**", "/member/memberLogin.do");
	}
}
