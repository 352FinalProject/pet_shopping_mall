package com.shop.app.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.entity.ProductOption;
import com.shop.app.product.repository.ProductRepository;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductRepository productRepository;

	@Override
	public List<ProductCategory> findAll() {
		return productRepository.findAll();
	}

	@Override
	public int insertProduct(Product product) {
		return productRepository.insertProduct(product);
	}

	@Override
	public List<Product> findAllBasicProduct() {
		return productRepository.findAllBasicProduct();
	}
	
	@Override
	public List<ProductDetail> findAllProductDetails() {
		return productRepository.findAllProductDetails();
	}
	
	@Override
	public Product findProductById(int productId) {
		return productRepository.findProductById(productId);
	}
	
	@Override
	public int updateProduct(Product product) {
		return productRepository.updateProduct(product);
	}
	
	@Override
	public int deleteProduct(int productId) {
		return productRepository.deleteProduct(productId);
	}

	@Override
	public int insertProductOption(ProductOption option) {
		return productRepository.insertProductOption(option);
	}

	@Override
	public List<ProductOption> findAllProductOptions() {
		return productRepository.findAllProductOptions();
	}

}
