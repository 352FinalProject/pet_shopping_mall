package com.shop.app.cart.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.cart.dto.CartDto;
import com.shop.app.cart.entity.CartItem;

@Mapper
public interface CartRepository {

	@Select("select * from cartitem i left join cart c on i.cart_id = c.cart_id where c.member_id= #{memberId}")
	List<CartItem> getCartList(String memberId);

	@Select("select * from cart where member_id = #{memberId}")
	int getMemberCart(String memberId);

}
