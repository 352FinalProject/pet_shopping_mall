package com.shop.app.cart.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.entity.Cart;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.product.entity.ProductDetail;

@Mapper
public interface CartRepository {

	@Select("select * from cartitem i left join cart c on i.cart_id = c.cart_id where c.member_id= #{memberId}")
	List<CartItem> getCartList(String memberId);
	
	CartInfoDto getCartInfoList(int productDetailId);

	@Select("select * from cart where member_id = #{memberId}")
	int getMemberCart(String memberId);


	@Delete("delete from cartitem ci where cartitem_id = #{cartitemId} and ci.cart_id = (select cart_id from cart where member_id =#{memberId})")
	int deleteCartOne(int cartitemId, String memberId);

	@Delete("delete from cartitem ci where ci.cart_id = (select cart_id from cart where member_id =#{memberId})")
	int deleteCartAll(String memberId);
	
	List<CartInfoDto> findProductOptionById(int productId);
	
	@Update("update cartitem set product_detail_id = #{productDetailId}, quantity = #{quantity} where cartitem_id = #{cartitemId}")
	int updateCart(CartItem cartitem);

	// 상품 페이지에서 장바구니 버튼 눌러서 장바구니에 담기 (예라)
	@Insert("insert into cartitem (cartitem_id, cart_id, product_detail_id, quantity) values (seq_cartitem_id.nextval, #{cartId}, #{productDetailId}, #{quantity})")
	int insertCart(int cartId, int optionId, int productDetailId, int quantity);

	// 장바구니 찾기 (예라)
	@Select("select c.cart_id from cart c join member m ON c.member_id = m.member_id where m.member_id = #{memberId}")
	int findCartById(String member);
}
