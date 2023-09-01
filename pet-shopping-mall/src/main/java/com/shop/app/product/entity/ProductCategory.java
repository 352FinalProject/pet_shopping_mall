package com.shop.app.product.entity;

import java.util.List;

import com.shop.app.common.entity.ImageAttachment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductCategory {
	private int categoryId;
	private String categoryName;
	private List<Product> product;
	private List<ImageAttachment> attachments;
}
