package com.shop.app.member.dto;

import javax.validation.constraints.NotBlank;

import lombok.Data;
@Data
public class MemberLoginDto {
	@NotBlank(message = "아이디는 필수입니다.")
	private String memberId;
	@NotBlank(message = "비밀번호는 필수입니다.")
	private String password;
}
