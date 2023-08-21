package com.shop.app.payment.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface PaymentRepository {
	
	@Update("update orderTbl set payment_status = 1 where order_no = #{orderNo}")
	int updatePayStatus(String orderNo);
}
