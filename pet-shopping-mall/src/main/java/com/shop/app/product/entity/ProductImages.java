package com.shop.app.product.entity;

import java.sql.Timestamp;
import java.util.List;

import javax.validation.constraints.NotNull;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.common.entity.ImageAttachmentMapping;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ProductImages {
	private int productId;
	private int categoryId; // 1: 사료, 2: 간식, 3: 패션용품, 4: 산책용품, 5: 위생용품, 6: 고양이, 7: 기타용품
	private String productName;
	private int productPrice;
	private int imageId;
	private Timestamp createDate;
	private int likeCnt;
	
	private List<ImageAttachment> attachments;
	private List<ImageAttachmentMapping> attachmentMapping;
	
	public Product toProduct() {
		return Product.builder()
				.categoryId(categoryId)
				.productName(productName)
				.productPrice(productPrice)
				.imageId(imageId)
				.build();
	}
	
}
