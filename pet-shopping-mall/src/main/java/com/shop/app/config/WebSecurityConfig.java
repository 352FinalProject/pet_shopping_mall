package com.shop.app.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

// Spring Security를 활성화하는 어노테이션
@SuppressWarnings("deprecation")
@EnableWebSecurity // @Configuration 상속
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	
	// 비밀번호 암호화를 위한 빈 생성
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	// 사용자 정보를 가져오는 서비스
	@Autowired
	private UserDetailsService memberService;
	
	// 데이터 소스 연결
	@Autowired
	private DataSource dataSource;
	
	
	// remember-me 기능을 위한 토큰 저장소 설정
	@Bean
	public PersistentTokenRepository tokenRepository() {
		JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
		tokenRepository.setDataSource(dataSource);
		return tokenRepository;
	}
	
	/**
	 * 실제 인증/인가를 담당하는 AuthenticationManager에 대한 설정
	 * - in memory
	 * - db 사용자
	 * - anonymous
	 * - authenticated
	 * - permitAll
	 * - hasRole/hasAuthority
	 * 
	 *  인증/인가 설정
	 *  폼로그인/로그아웃
	 *  ...
	 */

	// 인증 정보를 구성하는 메서드
		@Override
		protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//			auth.inMemoryAuthentication()
//				.passwordEncoder(passwordEncoder())
//				.withUser("sinsa")
//				.password(passwordEncoder().encode("1234"))
//				.authorities("ROLE_USER")
//				.and()
//				.withUser("admin")
//				.password(passwordEncoder().encode("1234"))
//				.authorities("ROLE_USER", "ROLE_ADMIN");
			
			auth.userDetailsService(memberService).passwordEncoder(passwordEncoder());

		}
	
	/**
	 * - anonymous
	 * - authenticated
	 * - permitAll
	 * - hasRole/hasAuthority
	 * 
	 * 인증/인가 설정
	 * 폼로그인/로그아웃
	 * ...
	 */
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/", "/index.jsp").permitAll()  // 모든 사용자 허용
			.antMatchers("/member/memberCreate.do", "/member/checkIdDuplicate.do").anonymous()  // 비로그인 사용자만 허용
			.antMatchers("/servicecenter/inquiry/questionCreate.do").permitAll()
//			.antMatchers("/admin/**").hasRole("ADMIN")
			.antMatchers("/admin/**").hasAuthority("ROLE_ADMIN");
//			.anyRequest().authenticated(); // 나머지 요청은 인증 필요
		
		
		http.formLogin()  
			.loginPage("/member/memberLogin.do")  // 로그인 페이지 경로
			.loginProcessingUrl("/member/memberLogin.do") // 로그인 성공시 이동할 URL
			.usernameParameter("memberId")
			.defaultSuccessUrl("/")  // 로그인 성공시 이동할 URL
			.permitAll(); // 모든 사용자 허용
		
		http.logout()
			.logoutUrl("/member/memberLogout.do")  // 로그아웃 URL
			.logoutSuccessUrl("/") // 로그아웃 성공시 이동할 URL
			.permitAll(); // 모든 사용자 허용
		
		// csrf (cross site request forgery) 공격대비 토큰 사용 (기본값)
		// http.csrf().disable(); // 토큰 사용안함
		
		// remember-me관련
		http.rememberMe() // remember-me 기능 설정(아이디 저장)
			.tokenRepository(tokenRepository())
			.key("hello-springboot-secret")
			.tokenValiditySeconds(60 * 60 * 24 * 14); // 2주
	}
	
	/**
	 * security bypasss 경로 지정
	 * - static파일 (js, css, images,...)
	 */
	
	// 보안 무시 경로 설정 (정적 자원에 대한 접근 허용)
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().mvcMatchers("/resources/**");
	}
	
	
	
}
