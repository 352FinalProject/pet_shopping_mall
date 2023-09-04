package com.shop.app.terms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.app.member.entity.TermsHistory;
import com.shop.app.terms.entity.Terms;
import com.shop.app.terms.repository.TermsRepository;

@Service
public class TermsServiceImpl implements TermsService  {

	@Autowired
	private TermsRepository termsRepository;
	
	@Override
	public int insertTerms(Terms terms) {
		return termsRepository.insertTerms(terms);
	}

	@Override
	public List<Terms> findTermsAll(Terms terms) {
		return termsRepository.findTermsAll(terms);
	}

	@Override
	public int insertTermsHistory(TermsHistory termsHistory) {
		return termsRepository.insertTermsHistory(termsHistory);
	}

	@Override
	public List<TermsHistory> fineTermsHistory() {
		return termsRepository.fineTermsHistory();
	}


	
}
