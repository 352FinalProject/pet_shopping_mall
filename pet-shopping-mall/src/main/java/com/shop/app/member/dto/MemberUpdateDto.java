package com.shop.app.member.dto;

import java.time.LocalDate;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import com.shop.app.member.entity.Member;
@Data
public class MemberUpdateDto {
	@NotBlank(message = "이름은 필수입니다.") 
	private String name;
	
	private String phone;
	
	@Email(message = "유효한 이메일을 작성해주세요.") 
	private String email;

	@NotBlank(message = "비밀번호는 필수입니다.")
	private String password;
	
	@NotBlank(message = "비밀번호는 필수입니다.")
	private String address;

	public Member toMember() {
		return Member.builder()
			.name(name)
			.phone(phone)
			.password(password)
			.email(email)
			.address(address)
			.build();
	}
	
}
