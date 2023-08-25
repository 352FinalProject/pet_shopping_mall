package com.shop.app.product.dto;

import java.util.List;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.common.entity.ImageAttachmentMapping;
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
	private int productDetailId;
	private int productId;
	private String optionName;
	private String optionValue;
	private int additionalPrice;
	private int saleState;
	private String productName;
	private int likeCnt;
	
	private ProductCategory productCategory; // 카테고리명 저장용
	private Product product; // 상품정보 저장용
	
	private List<ImageAttachment> attachments;
	private List<ImageAttachmentMapping> attachmentMapping;

}
