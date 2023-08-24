package com.shop.app.wishlist.service;

import java.util.List;
import java.util.Map;

import com.shop.app.wishlist.dto.WishlistDto;

public interface WishlistService {
	// 찜 여부 체크 (선모)
	int getLikeProduct(int productId, String memberId);
	
	// 찜 등록 (선모)
	int insertPick(int productId, String memberId);
	
	// 찜 제거 (선모)
	int deletePick(int productId, String memberId);
	
	// 내 찜 목록 가져오기 (선모)
	List<Map<String, Object>> getMyWishList(String memberId);
}