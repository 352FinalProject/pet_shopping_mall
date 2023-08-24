package com.shop.app.wishlist.service;

import java.util.List;
import java.util.Map;

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
	
	// 찜 여부 체크 (선모)
	@Override
	public int getLikeProduct(int productId, String memberId) {
		return wishlistRepository.getLikeProduct(productId, memberId);
	}

	// 찜 등록 (선모)
	@Override
	public int insertPick(int productId, String memberId) {
		return wishlistRepository.insertPick(productId, memberId);
	}
	
	// 찜 제거 (선모)
	@Override
	public int deletePick(int productId, String memberId) {
		return wishlistRepository.deletePick(productId, memberId);
	}

	// 내 찜 목록 가져오기 (선모)
	@Override
	public List<Map<String, Object>> getMyWishList(String memberId) {
		return wishlistRepository.getMyWishList(memberId);
	}	
}