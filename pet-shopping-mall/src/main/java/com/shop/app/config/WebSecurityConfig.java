package com.shop.app.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.member.repository.MemberRepository;
import com.shop.app.member.service.MemberService;

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
   private UserDetailsService userDetailsService;

   @Autowired
   private MemberService memberService;
   
   @Autowired
   private OAuth2UserService oauth2UserService;
   
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

   
   @Override
   protected void configure(AuthenticationManagerBuilder auth) throws Exception {
      auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
   }

   
   @Override
   protected void configure(HttpSecurity http) throws Exception {
      http.authorizeRequests().antMatchers("/", "/index.jsp", "/product/productDetail.do", "/servicecenter/service.do", "/product/productList.do").permitAll() // 모든 사용자 허용
            .antMatchers("/servicecenter/inquiry/**").hasAnyAuthority("ROLE_USER", "ROLE_ADMIN")
            .antMatchers("/member/terms.do","/member/memberCreate.do", "/member/checkIdDuplicate.do").anonymous() // 비로그인 사용자만 허용
            .antMatchers("/oauth/**", "/email/**", "/member/updateTerms.do", "/member/memberCreateComplete.do",  "/stomp/**", "/payment/proceed.do").permitAll()
            .antMatchers("/admin/**").hasAuthority("ROLE_ADMIN")
            .anyRequest().authenticated(); // 나머지 요청은 인증 필요

      http.formLogin().loginPage("/member/memberLogin.do") // 로그인 페이지 경로
            .loginProcessingUrl("/member/memberLogin.do") // 로그인 성공시 이동할 URL
            .usernameParameter("memberId").defaultSuccessUrl("/", true) // 로그인 성공시 이동할 URL
            .permitAll(); // 모든 사용자 허용

      http.logout().logoutUrl("/member/memberLogout.do") // 로그아웃 URL
            .logoutSuccessUrl("/") // 로그아웃 성공시 이동할 URL
            .permitAll(); // 모든 사용자 허용

      http.rememberMe() // remember-me 기능 설정(아이디 저장)
            .tokenRepository(tokenRepository()).key("saveId")
            .tokenValiditySeconds(60 * 60 * 24 * 14); // 2주
      
      http.oauth2Login()
      .loginPage("/member/memberLogin.do").defaultSuccessUrl("/", true)
      .userInfoEndpoint()
      .userService(oauth2UserService);
   }


   // 보안 무시 경로 설정 (정적 자원에 대한 접근 허용)
   @Override
   public void configure(WebSecurity web) throws Exception {
      web.ignoring().mvcMatchers("/resources/**");
   }
   
   
   // 인증 후에 로그인 객체를 세션에 저장하고 싶어서 메소드 오버라이딩 (담희)
   @Bean
   public AuthenticationSuccessHandler authenticationSuccessHandler() {
      return new AuthenticationSuccessHandler() {
         @Override
         public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                    Authentication authentication) throws IOException, ServletException {
            HttpSession session = request.getSession();
            
            if(authentication.getPrincipal() instanceof MemberDetails) {
               MemberDetails principal = (MemberDetails) authentication.getPrincipal();
               Member member = memberService.findMemberById(principal.getMemberId());
               
               session.setAttribute("loginMember", member);
            }
            response.sendRedirect("/");
         }
      };
   }

}