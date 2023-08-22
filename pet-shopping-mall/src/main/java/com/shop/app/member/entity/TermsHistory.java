package com.shop.app.member.entity;

import java.sql.Timestamp;

import com.shop.app.terms.entity.Accept;
import com.shop.app.terms.entity.Terms;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TermsHistory {
	
	private int termsId;
	private String title;
	private String content;
	private Required required;
}
