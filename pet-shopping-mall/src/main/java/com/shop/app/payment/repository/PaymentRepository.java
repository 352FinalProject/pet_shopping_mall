package com.shop.app.payment.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.order.entity.Order;
import com.shop.app.payment.dto.PaymentCompleteNotificationDto;
import com.shop.app.payment.entity.Payment;

@Mapper
public interface PaymentRepository {
	
	@Update("update orderTbl set payment_status = 1 where order_no = #{orderNo}")
	int updatePayStatus(String orderNo);

	@Insert("insert into payment (payment_id, payment_method, payment_date, amount, order_id) values (seq_payment_id.nextVal, #{paymentMethod}, default, #{amount}, #{orderId})")
	int insertPayment(Payment payment);

	@Select("select * from payment where order_id = ${orderId}")
	Payment getPaymentInfo(int orderId);

	@Insert("insert into sub_payment (sub_payment_id, member_id, payment_date) values (seq_sub_payment_id.nextVal, #{customerUid}, default)")
	int insertSubPayment(String customerUid);
	
	// 알림 (productName가져오기위한 메서드 - 대원)
	PaymentCompleteNotificationDto notificationFindOrderByOrderNo(String orderNo);
	
	

}
