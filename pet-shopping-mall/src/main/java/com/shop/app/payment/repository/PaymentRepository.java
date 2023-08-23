package com.shop.app.payment.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import com.shop.app.payment.entity.Payment;

@Mapper
public interface PaymentRepository {
	
	@Update("update orderTbl set payment_status = 1 where order_no = #{orderNo}")
	int updatePayStatus(String orderNo);

	@Insert("insert into payment (payment_id, payment_method, payment_date, amount, order_id) values (seq_payment_id.nextVal, 1, default, #{amount}, #{orderId})")
	int insertPayment(Payment payment);
}
