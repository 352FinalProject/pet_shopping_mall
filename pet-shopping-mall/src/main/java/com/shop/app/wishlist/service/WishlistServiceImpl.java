package com.shop.app.wishlist.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.service.ProductServiceImpl;
import com.shop.app.wishlist.repositoty.WishlistRepository;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class WishlistServiceImpl implements WishlistService {
	@Autowired
	private WishlistRepository wishlistRepository;
	/**
	 * @author 강선모
	 * 찜 여부 체크 
	 */
	@Override
	public int getLikeProduct(int productId, String memberId) {
		return wishlistRepository.getLikeProduct(productId, memberId);
	}
	/**
	 * @author 강선모
	 * 찜 등록
	 */
	@Override
	public int insertPick(int productId, String memberId) {
		return wishlistRepository.insertPick(productId, memberId);
	}
	/**
	 * @author 강선모
	 * 찜 제거
	 */ 
	@Override
	public int deletePick(int productId, String memberId) {
		return wishlistRepository.deletePick(productId, memberId);
	}
	/**
	 * @author 강선모
	 * 내 찜 목록 가져오기
	 */
	@Override
	public int getListCount(Map<String, Object> paramMap) {
		return wishlistRepository.getListCount(paramMap);
	}	
	/**
	 * @author 강선모
	 * 내 찜 목록 가져오기(페이징바)
	 * limit 페이지당 보여줄 아이템 숫자
	 * page 페이지 번호
	 * offset 페이지를 위한 오프셋, 현재 페이지에 따라 계산되며 페이지당 limit를 곱해줌으로 시작 위치를 계산
	 */
	@Override
	public List<Map<String, Object>> getMyWishList(Map<String, Object> paramMap) {
		int limit = (int) paramMap.get("limit");
		int page = (int) paramMap.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return wishlistRepository.getMyWishList(rowBounds, paramMap);
	}	
}