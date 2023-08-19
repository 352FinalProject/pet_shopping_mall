package com.shop.app.order.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.shop.app.order.entity.Order;

@Mapper
public interface OrderRepository {

	@Insert("insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code) values(seq_orderTbl_id.nextVal, #{orderNo}, #{memberId}, default, default, default, #{totalPrice}, #{deliveryFee}, #{discount}, #{amount}, #{discountCode})")
	int insertOrder(Order order);

}
