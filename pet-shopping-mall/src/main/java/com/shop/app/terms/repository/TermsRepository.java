package com.shop.app.terms.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.terms.entity.Terms;

@Mapper
public interface TermsRepository {

    @Insert("insert into terms(history_id, member_id, terms_id, accept, accept_date)"
            + " values (#{historyId}, #{memberId}, #{termsId}, #{accept}, #{acceptDate, jdbcType = TIMESTAMP})")
    int insertTerms(Terms terms);

    @Select("select * from terms order by terms_id desc")
    List<Terms> findTermsAll(Terms terms);

}
