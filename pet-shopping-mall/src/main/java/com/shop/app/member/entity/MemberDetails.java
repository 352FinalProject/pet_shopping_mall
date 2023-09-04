package com.shop.app.member.entity;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.shop.app.point.entity.Point;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(callSuper = true)
public class MemberDetails extends Member implements UserDetails, OAuth2User  { 
	
	/**
	 * WAS상에서 MemberDetails객체 단위로 입출력 진행시의 식별번호
	 */
	private static final long serialVersionUID = 1L;
	
	private List<SimpleGrantedAuthority> authorities;
	private Map<String, Object> attributes;
	
	
	@Override
	public Map<String, Object> getAttributes() {
		return this.attributes;
	}
	
    
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.authorities;
	}

	@Override
	public String getUsername() {
		return this.getMemberId();
	}

	/**
	 * 만료된 사용자인가?
	 */
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	/**
	 * 락된 사용자인가?
	 */
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	/**
	 * 비밀번호가 유효한가?
	 */
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	/**
	 * 활성화된 사용자인가?
	 */
	@Override
	public boolean isEnabled() {
		return true;
	}


	public void setPoint(int i) {
		
	}
}
