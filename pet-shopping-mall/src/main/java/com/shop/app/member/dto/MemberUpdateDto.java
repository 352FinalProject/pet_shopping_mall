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
	@NotBlank(message = "이름은 필수입니다.") // null, "", "  " 모두 허용하지 않음
	private String name;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthday;
	
	@Email(message = "유효한 이메일을 작성해주세요.") // "" 허용
	private String email;

	@NotBlank(message = "비밀번호는 필수입니다.")
	@Pattern(regexp = "\\w{4,}", message = "비밀번호는 영문자/숫자 4글자이상이어야 합니다.")
	private String password;
	
	public Member toMember() {
		return Member.builder()
			.name(name)
			.password(password)
			.birthday(birthday)
			.email(email)
			.build();
	}
}
