package com.shop.app.cart.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.product.entity.ProductDetail;

@Mapper
public interface CartRepository {

	@Select("select * from cartitem i left join cart c on i.cart_id = c.cart_id where c.member_id= #{memberId}")
	List<CartItem> getCartList(String memberId);

	@Select("select * from cart where member_id = #{memberId}")
	int getMemberCart(String memberId);

	CartInfoDto getCartInfoList(int productDetailId);

	@Delete("delete from cartitem ci where cartitem_id = #{cartitemId} and ci.cart_id = (select cart_id from cart where member_id =#{memberId})")
	int deleteCartOne(int cartitemId, String memberId);

	@Delete("delete from cartitem ci where ci.cart_id = (select cart_id from cart where member_id =#{memberId})")
	int deleteCartAll(String memberId);
	
	List<CartInfoDto> findProductOptionById(int productId);
	
	@Update("update cartitem set product_detail_id = #{productDetailId}, quantity = #{quantity} where cartitem_id = #{cartitemId}")
	int updateCart(CartItem cartitem);

}
