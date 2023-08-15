package com.shop.app.cart.dto;

import java.util.List;
import java.util.Map;

import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductDetail;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartInfoDto{
	Map<ProductDetail, Integer> productInfo;
	Map<Product, Integer> priceInfo;
}
