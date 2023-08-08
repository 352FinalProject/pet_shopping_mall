package com.shop.app.member.entity;

import java.sql.Date;
import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private int id;
	private String memberId;
	private String password;
	private String name;
	private String phone;
	private String email;
	private Date enrollDate;
	private String address;
	private LocalDate birthday;
	private MemberRole memberRole;
	private int point;
	private Subscribe subscribe;
	
}
