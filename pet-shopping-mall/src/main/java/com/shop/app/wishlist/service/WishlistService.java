package com.shop.app.wishlist.service;

import java.util.List;
import java.util.Map;

import com.shop.app.wishlist.dto.WishlistDto;

public interface WishlistService {
	/**
	 * @author 강선모
	 * 찜 여부 체크
	 */
	int getLikeProduct(int productId, String memberId);
	/**
	 * @author 강선모
	 * 찜 등록
	 */ 
	int insertPick(int productId, String memberId);
	/**
	 * @author 강선모
	 * 찜 제거
	 */ 
	int deletePick(int productId, String memberId);
	/**
	 * @author 강선모
	 * 내 찜 목록 개수 가져오기
	 */
	int getListCount(Map<String, Object> paramMap);
	/**
	 * @author 강선모
	 * 내 찜 목록 가져오기 
	 */
	List<Map<String, Object>> getMyWishList(Map<String, Object> paramMap);
	
}