package com.shop.app.cart.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.cart.dto.CartInfoDto;
import com.shop.app.cart.dto.PurchaseDto;
import com.shop.app.cart.entity.CartItem;
import com.shop.app.cart.repository.CartRepository;
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
	
	
	/**
	 * @author 김담희
	 * 회원 아이디로 cartitem 테이블을 조회하여, 장바구니 안 모든 상품에 대해
	 * 상품의 정보를 담고있는 List<CartInfoDto> 에 넣어 반환
	 */
	@Override
	public List<CartInfoDto> getCartInfoList(String memberId) {
		List<CartItem> cartItemList = cartRepository.getCartList(memberId);
		List<CartInfoDto> cartInfoList = new ArrayList<>();
		CartInfoDto product = null;
		for(int i=0; i <cartItemList.size(); i++) {
			product = cartRepository.getCartInfoList(cartItemList.get(i).getProductDetailId(), cartItemList.get(i).getCartitemId());
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

	
	/**
	 * @author 김담희
	 * 장바구니에서 옵션을 변경
	 * 장바구니에 이미 동일한 옵션의 아이템이 담겨있을 시, 수량만 변경
	 * 다른 옵션을 선택할 경우 옵션과 수량 모두 변경
	 * 
	 */
	@Override
	public int updateCart(CartItem cartitem, String memberId) {
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
	
	@Override
	public int findCartById(String member) {
		return cartRepository.findCartById(member);
	}


	/**
	 * @author 김담희
	 * 상품 상세 페이지에서 장바구니에 넣기를 선택할 때,
	 * 장바구니에 이미 동일한 옵션 값의 상품이 담겨있다면 update 처리
	 * 그렇지 않으면 insert
	 */
	@Override
	public int insertCart(String memberId, int productDetailId, int quantity) {
	    List<CartInfoDto> cartList = getCartInfoList(memberId);
	    int cartId = findCartById(memberId);
	    
	    int result = 0;
	    boolean found = false;

	    for (CartInfoDto c : cartList) {
	        int detailId = c.getProductDetailId();
	        if (detailId == productDetailId) {
	            int cartitemId = c.getCartitemId();

	            CartItem cartitem = CartItem.builder()
	                    .cartitemId(cartitemId)
	                    .cartId(cartId)
	                    .quantity(quantity)
	                    .productDetailId(productDetailId)
	                    .build();
	            result = cartRepository.updateCart(cartitem);
	            found = true;
	            break; 
	        }
	    }
	    if (!found) {
	        CartItem cartitem = CartItem.builder()
	                .cartId(cartId)
	                .quantity(quantity)
	                .productDetailId(productDetailId)
	                .build();
	        result = cartRepository.insertCart(cartitem);
	    }
	    return result;
	}


	/**
	 * @author 김담희
	 * 상품 상세페이지에서 상품 단일 구매를 선택했을 때, 해당 상품에 대해서만 정보를 조회
	 */
	@Override
	public PurchaseDto paymentOneInfo(int productDetailId) {
		return cartRepository.paymentOneInfo(productDetailId);
	}

}
