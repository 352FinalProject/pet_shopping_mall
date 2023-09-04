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
	
	// 찜 여부 체크 
	@Override
	public int getLikeProduct(int productId, String memberId) {
		return wishlistRepository.getLikeProduct(productId, memberId);
	}

	// 찜 등록 
	@Override
	public int insertPick(int productId, String memberId) {
		return wishlistRepository.insertPick(productId, memberId);
	}
	
	// 찜 제거 
	@Override
	public int deletePick(int productId, String memberId) {
		return wishlistRepository.deletePick(productId, memberId);
	}
	
	// 내 찜 목록 가져오기
	@Override
	public int getListCount(Map<String, Object> paramMap) {
		return wishlistRepository.getListCount(paramMap);
	}	
	
	// 내 찜 목록 가져오기
	@Override
	public List<Map<String, Object>> getMyWishList(Map<String, Object> paramMap) {
		int limit = (int) paramMap.get("limit");
		int page = (int) paramMap.get("page");
		int offset = (page - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return wishlistRepository.getMyWishList(rowBounds, paramMap);
	}	
}