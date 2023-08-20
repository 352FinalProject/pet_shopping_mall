package com.shop.app.terms.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.terms.entity.Terms;

@Mapper
public interface TermsRepository {

    @Insert("insert into terms(history_id, terms_id, member_id, accept_yn, accept_date)"
            + " values (seq_history_id.nextval, seq_terms_id.nextval, #{memberId}, #{accept}, default)")
    int insertTerms(Terms terms);

    @Select("select * from terms order by terms_id desc")
    List<Terms> findTermsAll(Terms terms);

}
