package com.shop.app.member.entity;

import java.util.Date;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Member {
	private int id;
	private String memberId;
	private String password;
	private String name;
	private String phone;
	private String email;
	private Date enrollDate;
	private String address;
	private Date birthday;
	private MemberRole memberRole;
	private int point;
	private Subscribe subscribe;
	
}
