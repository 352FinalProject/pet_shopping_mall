package com.shop.app.product.service;

import java.util.List;

import javax.validation.constraints.NotNull;

import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.entity.ProductImages;

public interface ProductService {
	// 수경
	List<ProductCategory> findAll();
	// 수경
	int insertProduct(ProductImages productImages);
	// 수경
	ProductDetail findProductDetailById(int productId);
	
	// 수경
	List<ProductDetail> findAllProductDetails();

	// 수경
	Product findProductById(int productId);

	// 수경
	int updateProduct(Product product);

	// 수경
	int deleteProduct(int productId);
	
	// 수경
	ProductCategory findProductCategoryById(int categoryId);

	// 수경
	int insertProductDetail(ProductDetail productDetail);

	// 수경
	ProductImages findImageAttachmentsByProductId(int productId);

	// 수경
	List<ProductDetail> findAllProductDetailsByProductId(int productId);

	// 수경
	int updateProductDetail(ProductDetail productDetail);

	// 수경
	int deleteProductDetail(int productDetailId);

	List<Product> findProduct();
	
	// 수경
	List<Product> findProductsByCategoryId(int categoryId);
	
	// 찜 수 증가 (선모)
	int updateLikeCnt(int productId);


}