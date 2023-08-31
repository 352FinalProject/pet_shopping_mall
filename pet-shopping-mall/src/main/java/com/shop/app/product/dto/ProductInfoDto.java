package com.shop.app.product.dto;

import java.util.List;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.common.entity.ImageAttachmentMapping;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.review.dto.ProductReviewAvgDto;

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
	
	private int productId;
	
	private ProductCategory productCategory; // 카테고리명 저장용
	private Product product; // 상품정보 저장용
	private List<ProductDetail> productDetails; // 해당 상품 아이디에 해당하는 productDetail 객체를 모아둠
	private int orderCnt; // 구매확정된 주문의 수
	private List<ImageAttachment> attachments;
	private List<ImageAttachmentMapping> attachmentMapping;
	
	private int reviewCnt; // 리뷰 전체 개수

	private ProductReviewAvgDto productReviewStarAvg; // 리뷰 평균 별점 dto

}
