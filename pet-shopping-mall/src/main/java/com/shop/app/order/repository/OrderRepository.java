package com.shop.app.order.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.shop.app.order.entity.Order;

@Mapper
public interface OrderRepository {

	@Insert("insert into orderTbl values(seq_orderTbl_id.nextVal, #{orderNo}, #{memberId}, default, default, default, #{totalPrice}, #{deliveryFee}, #{discount}, #{amount})")
	int insertOrder(Order order);

}
