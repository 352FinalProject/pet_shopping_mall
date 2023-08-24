package com.shop.app.wishlist.service;

public interface WishlistService {
	// 찜 여부 체크
	int getLikeProduct(int productId, String memberId);
}