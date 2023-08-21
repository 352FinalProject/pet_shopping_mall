package com.shop.app.product.service;

import java.util.List;

import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;

public interface ProductService {

	List<ProductCategory> findAll();

	int insertProduct(Product product);

	List<Product> findAllBasicProduct();

	List<ProductDetail> findAllProductDetails();

	Product findProductById(int productId);
	
	


}
