package com.shop.app.product.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.entity.ProductImages;
import com.shop.app.product.repository.ProductRepository;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;
import com.shop.app.servicecenter.inquiry.repository.QuestionRepository;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductRepository productRepository;
	
	@Autowired
	private QuestionRepository questionRepository;

	@Override
	public List<ProductCategory> findAll() {
		return productRepository.findAll();
	}

	@Override
	public int insertProduct(ProductImages productImages) {
		int result =0;
		Product product = productImages.toProduct();
		result = productRepository.insertProduct(product);
		log.debug("product = {}", product);
		
		int refId = product.getProductId();
		int productId = refId;
		
		// 첨부이미지 저장
		List<ImageAttachment> attachments = productImages.getAttachments();
		if(attachments != null && !attachments.isEmpty()) {
			for(ImageAttachment attach : attachments) {
				
				// 1. 이미지 파일 저장
				int result2 = productRepository.insertAttachment(attach);
				
				// 2. 이미지파일 DB저장후 생성된 이미지 아이디 가져오기
				int imageId = attach.getImageId(); 
				log.debug("imageId = {}", imageId);
				// 3. 상품 ID와 이미지 ID를 사용하여 매핑 정보를 데이터베이스에 저장
				int result3 = productRepository.insertMapping(refId, imageId);
				// product에 imageId 세팅
				int result4 = productRepository.updateImageIdByProductId(productId, imageId);
			}
		}
		return productId;
	}

	@Override
	public List<ProductDetail> findAllProductDetails() {
		return productRepository.findAllProductDetails();
	}
	
	@Override
	public ProductDetail findProductDetailById(int productId) {
		return productRepository.findProductDetailById(productId);
	}
	
	@Override
	public Product findProductById(int productId) {
		return productRepository.findProductById(productId);
	}
	
	@Override
	public ProductImages findImageAttachmentsByProductId(int productId) {
		return productRepository.findImageAttachmentsByProductId(productId);
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
	public ProductCategory findProductCategoryById(int categoryId) {
		return productRepository.findProductCategoryById(categoryId);
	}

	@Override
	public int insertProductDetail(ProductDetail productDetail) {
		return productRepository.insertProductDetail(productDetail);
	}
	
	@Override
	public List<ProductDetail> findAllProductDetailsByProductId(int productId) {
		return productRepository.findAllProductDetailsByProductId(productId);
	}
	
	@Override
	public int updateProductDetail(ProductDetail productDetail) {
		return productRepository.updateProductDetail(productDetail);
	}

	@Override
	public int deleteProductDetail(int productDetailId) {
		return productRepository.deleteProductDetail(productDetailId);
	}

	@Override
	public List<Product> findProduct() {
		return productRepository.findProduct();
	}
	
	@Override
	public List<Product> findProductsByCategoryId(int categoryId) {
		return productRepository.findProductsByCategoryId(categoryId);
	}

	// 찜 수 증감 (선모)
	@Override
	public int updateLikeCnt(Map<String, Object> param) {
		return productRepository.updateLikeCnt(param);
	}
}