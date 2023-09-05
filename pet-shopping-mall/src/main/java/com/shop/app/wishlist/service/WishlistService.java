package com.shop.app.wishlist.service;

import java.util.List;
import java.util.Map;

import com.shop.app.wishlist.dto.WishlistDto;

public interface WishlistService {
	/**
	 * @author 강선모
	 * 찜 여부 체크
	 * 특정 회원이 특정 상품을 찜했는지 여부를 확인
	 */
	int getLikeProduct(int productId, String memberId);
	/**
	 * @author 강선모
	 * 찜 등록
	 * 새로운 찜을 추가할 때 사용.
	 */ 
	int insertPick(int productId, String memberId);
	/**
	 * @author 강선모
	 * 찜 제거
	 * 이미 찜한 상품을 찜 목록에서 제거할 때 사용
	 */ 
	int deletePick(int productId, String memberId);
	/**
	 * @author 강선모
	 * 내 찜 목록 개수 가져오기
	 * 페이지네이션과 함께 사용되어 목록의 총 개수를 계산하는 데 사용
	 */
	int getListCount(Map<String, Object> paramMap);
	/**
	 * @author 강선모
	 * 내 찜 목록 가져오기 
	 * 회원의 찜 목록을 가져오는 메서드, 페이징된 결과 목록을 반환
	 */
	List<Map<String, Object>> getMyWishList(Map<String, Object> paramMap);
	
}