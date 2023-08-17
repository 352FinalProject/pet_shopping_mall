package com.shop.app.cart.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.cart.entity.CartItemDetails;
import com.shop.app.cart.repository.CartRepository;
import com.shop.app.member.entity.Member;
import com.shop.app.product.dto.ProductPriceDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.repository.ProductRepository;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class CartServiceImpl implements CartService {

	@Autowired
	private ProductRepository productRepository;
	
	@Autowired
	private CartRepository cartRepository;
	
	
	@Override
	public CartInfoDto getCartList(String memberId) {
		// 1. 멤버 아이디로 카트(cart) 조회 (쿼리문 쪼인처리하면 될듯)
		List<CartItem> cartItemList = cartRepository.getCartList(memberId);
		log.debug("cartItem codeList = {}", cartItemList);
		
		// 걍 쪼인해서 가져오자 List로...
		
		List<CartInfoDto> cartInfoList = new ArrayList<>();
		
		
		for(int i=0; i <cartItemList.size(); i++) {
			// cartRepository.getProductList(cartItemList.get(i).getProductDetailId());

			/*
			 * 
			 * select 
    p.*,
    pd.*
from 
    product p left join product_detail pd on p.product_id = pd.product_id
    left join cartitem ci on pd.product_detail_id = ci.product_detail_id
where 
    ci.product_detail_id = 2;
			 * 
			 * 
			 * 
			 * */
			
			
			//			product = productRepository.findProductDetailById(cartItemList.get(i).getProductDetailId());
//			
//			productInfo.put(product, cartItemList.get(i).getQuantity());
////			priceList.add(map.of(cartRepository.getPrice(product.getProductId()));
//			// 상품, 상품가격 가져와서 넣기~
		}

		return null;
	}

}
