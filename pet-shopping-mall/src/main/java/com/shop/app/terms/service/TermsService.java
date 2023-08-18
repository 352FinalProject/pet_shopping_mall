package com.shop.app.terms.service;

import java.util.List;

import com.shop.app.terms.entity.Terms;

public interface TermsService {

	int insertTerms(Terms terms);

	List<Terms> findTermsAll(Terms terms);


}
