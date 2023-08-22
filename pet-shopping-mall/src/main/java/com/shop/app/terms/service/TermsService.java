package com.shop.app.terms.service;

import java.util.List;

import com.shop.app.member.entity.TermsHistory;
import com.shop.app.terms.entity.Terms;

public interface TermsService {

	int insertTerms(Terms terms);

	List<Terms> findTermsAll(Terms terms);

	int insertTermsHistory(TermsHistory termsHistory);

	// 약관동의 이력 테이블 참조하여 회원 동의 이력 추가
	List<TermsHistory> fineTermsHistory();


}
