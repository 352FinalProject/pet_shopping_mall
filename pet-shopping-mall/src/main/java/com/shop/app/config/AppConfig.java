//package com.shop.app.config;
//
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//
//import com.shop.app.common.interceptor.AuthNullCheckInterceptor;
//import com.shop.app.common.interceptor.LogInterceptor;
//
//@Configuration
//public class AppConfig implements WebMvcConfigurer {
//	
//	@Override
//	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(new LogInterceptor())
//				.addPathPatterns("/**")
//				.excludePathPatterns("/resources/**");
//		
//		registry.addInterceptor(new AuthNullCheckInterceptor())
//				.addPathPatterns("/**")
//				.excludePathPatterns("/resources/**", "/member/memberLogin.do");
//			
//		
//	}
//	
//}
