package com.shop.app.wishlist.repositoty;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface WishlistRepository {
	// 찜 여부 체크
	@Select("SELECT COUNT(*) FROM wishlist WHERE WISHLIST_PRODUCT_ID = #{productId} AND WISHLIST_MEMBER_ID = #{memberId}")
	int getLikeProduct(int productId, String memberId);
	
}