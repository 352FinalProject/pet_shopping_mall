package com.shop.app.order.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.shop.app.order.entity.Order;

@Mapper
public interface OrderRepository {

	@Insert("insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code) values(seq_orderTbl_id.nextVal, #{orderNo}, #{memberId}, default, default, default, #{totalPrice}, #{deliveryFee}, #{discount}, #{amount}, #{discountCode, jdbcType=VARCHAR})")
	int insertOrder(Order order);

	// 2. db에서 주문 정보 가져오기 (예라)
	@Select("select * from (select * from orderTbl where member_id = #{memberId} order by order_id desc) where rownum <= 1")
	Order findByOrder(Order order);

}
