package com.shop.app.wishlist.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Wishlist {
	private int wishlistId;
	private String wishlistMemberId;
	private int wishlistProductId;
}
