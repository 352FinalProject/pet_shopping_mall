package com.shop.app.order.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.shop.app.order.dto.OrderAdminListDto;
import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.entity.CancelOrder;
import com.shop.app.order.entity.Order;
import com.shop.app.order.entity.OrderDetail;

@Mapper
public interface OrderRepository {

	@Insert("insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code) values(seq_orderTbl_id.nextVal, #{orderNo}, #{memberId}, default, default, default, #{totalPrice}, #{deliveryFee}, #{discount}, #{amount}, #{discountCode, jdbcType=VARCHAR})")
	@SelectKey(
			before = false,
			keyProperty = "orderId",
			resultType = int.class,
			statement = "select seq_orderTbl_id.currval from dual"
	)
	int insertOrder(Order order);
	
	
	List<OrderAdminListDto> adminOrderList();

	
	// 2. db에서 주문 정보 가져오기 (예라)
	@Select("select * from (select * from orderTbl where member_id = #{memberId} order by order_id desc) where rownum <= 1")
	Order findByOrder(Order order);

	
	@Update("update orderTbl set order_status = #{i} where order_no = #{orderNo}")
	int updateOrderStatus(String orderNo, int i);

	
	List<OrderHistoryDto> getOrderList(String memberId);
	
	
	@Insert("insert into order_detail (order_id, product_detail_id, quantity) values (#{orderId}, #{productDetailId}, #{quantity})")
	int insertOrderDetail(OrderDetail orderDetail);
	
	
	
	@Delete("insert into cancel_order (cancel_id, request_date, receipt_date, cancel_status, order_id) values (seq_cancel_id.nextVal, default, null, default, #{orderId})")
	int insertCancelOrder(CancelOrder cancel);
	
	
	@Select("select * from orderTbl where order_no = #{orderNo}")
	Order findOrderByOrderNo(String orderNo);
	
}
