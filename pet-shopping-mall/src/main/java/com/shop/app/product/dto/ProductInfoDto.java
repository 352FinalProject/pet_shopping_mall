package com.shop.app.product.dto;

import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

/**
 * @author 전수경
 * - 상품의 카테고리, 가격, 옵션가 등의 정보를 종합한 객체
 *
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductInfoDto {
	@NonNull
	private int productId;
	private String optionName;
	private String optionValue;
	private int additionalPrice;
	private int sale_state; // default=0(판매대기) 1: 판매중 2: 품절 3: 기타
	
	private ProductCategory productCategory; // 카테고리명 저장용
	private Product product; // 상품정보 저장용
	
	public ProductDetail toProductDetail() {
		return ProductDetail.builder()
				.optionName(optionName)
				.optionValue(optionValue)
				.additionalPrice(additionalPrice)
				.sale_state(sale_state)
				.build();
	}
	

}
