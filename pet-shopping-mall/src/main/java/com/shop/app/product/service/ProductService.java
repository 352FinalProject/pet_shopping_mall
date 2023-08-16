package com.shop.app.product.service;

import java.util.List;

import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;

public interface ProductService {

	List<ProductCategory> findAll();

	int insertProduct(Product product);

}
