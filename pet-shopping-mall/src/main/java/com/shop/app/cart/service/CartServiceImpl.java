package com.shop.app.cart.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.entity.Cart;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.cart.repository.CartRepository;
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
	public List<CartInfoDto> getCartInfoList(String memberId) {
		List<CartItem> cartItemList = cartRepository.getCartList(memberId);
		List<CartInfoDto> cartInfoList = new ArrayList<>();
		
		CartInfoDto product = null;
		
		for(int i=0; i <cartItemList.size(); i++) {
			product = cartRepository.getCartInfoList(cartItemList.get(i).getProductDetailId());
			cartInfoList.add(product);
		}

		return cartInfoList;
	}


	@Override
	public int deleteCartOne(int cartitemId, String memberId) {
		return cartRepository.deleteCartOne(cartitemId, memberId);
	}


	@Override
	public int deleteCartAll(String memberId) {
		return cartRepository.deleteCartAll(memberId);
	}


	@Override
	public List<CartInfoDto> findProductOptionById(int id) {
		return cartRepository.findProductOptionById(id);
	}


	@Override
	public int updateCart(CartItem cartitem, String memberId) {
	    log.debug("cartitem = {}", cartitem);
	    int detailId = cartitem.getProductDetailId();
	    List<CartItem> cartList = cartRepository.getCartList(memberId);
	    int result = 0;

	    for (CartItem c : cartList) {
	        int _detailId = c.getProductDetailId();
	        if (detailId == _detailId) {
	            CartItem updateCartItem = CartItem.builder()
	                    .cartitemId(c.getCartitemId())
	                    .quantity(cartitem.getQuantity())
	                    .productDetailId(c.getProductDetailId())
	                    .build();
	            result = cartRepository.updateCart(updateCartItem);
	            break;
	        }
	    }
	    
	    if (result == 0) {
	        cartRepository.updateCart(cartitem);
	    }

	    return result;
	}


	// 장바구니 찾기 (예라)
	@Override
	public int findCartById(String member) {
		return cartRepository.findCartById(member);
	}


	@Override
	public int insertCart(String memberId, int productDetailId, int quantity) {
	    List<CartInfoDto> cartList = getCartInfoList(memberId);
	    int cartId = findCartById(memberId);
	    
	    int result = 0;
	    boolean found = false; // detailId를 찾았는지 여부를 나타내는 플래그

	    for (CartInfoDto c : cartList) {
	        int detailId = c.getProductDetailId();
	        if (detailId == productDetailId) {
	            int cartitemId = c.getCartitemId();

	            log.debug("detailId = {}", detailId);

	            CartItem cartitem = CartItem.builder()
	                    .cartitemId(cartitemId)
	                    .cartId(cartId)
	                    .quantity(quantity)
	                    .productDetailId(productDetailId)
	                    .build();
	            // 수량 업데이트
	            result = cartRepository.updateCart(cartitem);
	            found = true;
	            break; 
	        }
	    }

	    if (!found) {
	        log.debug("detailId not found");
	        
	        CartItem cartitem = CartItem.builder()
	                .cartId(cartId)
	                .quantity(quantity)
	                .productDetailId(productDetailId)
	                .build();
	        result = cartRepository.insertCart(cartitem);
	    }

	    return result;
	}

}
