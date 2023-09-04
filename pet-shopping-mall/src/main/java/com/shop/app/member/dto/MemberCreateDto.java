package com.shop.app.member.dto;

import java.time.LocalDate;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;



@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberCreateDto {
	@NotBlank(message = "아이디는 필수입니다.")
	private String memberId;
	
	@NotBlank(message = "비밀번호는 필수입니다.")
	private String password;
	
	@NotBlank(message = "이름은 필수입니다.")
	private String name;
	
	@NotBlank(message = "핸드폰 번호는 필수입니다.")
	private String phone;
	
	private String address;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthday;
	
	private String email;
	
	private boolean isPromotion;

	public void setPoint(int i){}

	
}
