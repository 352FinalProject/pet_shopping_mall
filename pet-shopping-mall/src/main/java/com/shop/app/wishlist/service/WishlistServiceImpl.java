package com.shop.app.wishlist.service;

import java.util.List;

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
	
}