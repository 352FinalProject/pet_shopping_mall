package com.shop.app.product.entity;

import java.sql.Timestamp;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.springframework.lang.Nullable;

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
public class Product {
	@NotNull
	private int productId;
	@NotNull(message = "상품카테고리는 필수입력입니다.")
	private int categoryId; // 1: 사료, 2: 간식, 3: 패션용품, 4: 산책용품, 5: 위생용품, 6: 고양이, 7: 기타용품
	@NotNull(message = "상품명은 필수입력입니다.")
	private String productName;
	@NotNull(message = "상품가격은 필수입력입니다.")
	private int productPrice;
	private int imageId;
	private Timestamp createDate;
	private int likeCnt;

}
