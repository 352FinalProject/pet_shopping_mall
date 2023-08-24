package com.shop.app.product.service;

import java.util.List;

import javax.validation.constraints.NotNull;

import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.entity.ProductImages;

public interface ProductService {

	List<ProductCategory> findAll();

	int insertProduct(ProductImages productImages);

	ProductDetail findProductDetailById(int productId);
	
	List<ProductDetail> findAllProductDetails();

	ProductInfoDto findProductById(int productId);

	int updateProduct(Product product);

	int deleteProduct(int productId);

	ProductCategory findProductCategoryById(int categoryId);

	int insertProductDetail(ProductDetail productDetail);

	ProductImages findImageAttachmentsByProductId(int productId);

	List<ProductDetail> findAllProductDetailsByProductId(int productId);

	int updateProductDetail(ProductDetail productDetail);

	int deleteProductDetail(int productDetailId);


}