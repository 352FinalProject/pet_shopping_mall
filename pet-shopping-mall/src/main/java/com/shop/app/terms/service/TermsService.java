package com.shop.app.terms.service;

import java.util.List;

import com.shop.app.member.entity.TermsHistory;
import com.shop.app.terms.entity.Terms;

public interface TermsService {

	int insertTerms(Terms terms);

	List<Terms> findTermsAll(Terms terms);

	int insertTermsHistory(TermsHistory termsHistory);

	List<TermsHistory> fineTermsHistory();


}
