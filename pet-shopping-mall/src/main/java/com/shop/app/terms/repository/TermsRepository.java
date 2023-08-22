package com.shop.app.terms.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.member.entity.TermsHistory;
import com.shop.app.terms.entity.Terms;

@Mapper
public interface TermsRepository {

	@Insert("insert into terms(terms_id, member_id, terms_accept_yn, policy_accept_yn, email_accept_yn, terms_accept_required, policy_accept_required, email_accept_required, accept_date)"
	        + " values (seq_terms_id.nextval, #{memberId}, #{termsAccept}, #{privacyAccept}, #{EmailAccept}, #{termsAcceptRequired}, #{privacyAcceptRequired}, #{emailAcceptRequired}, default)")
    int insertTerms(Terms terms);

    @Select("select * from terms order by terms_id desc")
    List<Terms> findTermsAll(Terms terms);

	@Insert("insert into terms_history (terms_id, title, content) values (seq_terms_history_id.nextval, #{title}, #{content})")
	int insertTermsHistory(TermsHistory termsHistory);

}
