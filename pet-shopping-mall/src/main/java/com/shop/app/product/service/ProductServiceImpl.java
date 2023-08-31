package com.shop.app.product.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.dto.ProductSearchDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.entity.ProductImages;
import com.shop.app.product.repository.ProductRepository;
import com.shop.app.review.dto.ProductReviewAvgDto;
import com.shop.app.review.repository.ReviewRepository;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;
import com.shop.app.servicecenter.inquiry.repository.QuestionRepository;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ReviewRepository reviewRepository;
	
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
	
	
	// index 검색 (담희)
	@Override
	public List<ProductSearchDto> searchProducts(String searchQuery) {
		List<ProductSearchDto> productList = productRepository.searchProducts(searchQuery);
		
		for(ProductSearchDto p : productList) {
			int cnt = reviewRepository.findProductListReviewTotalCount(p.getProductId());
			p.setReviewCnt(cnt);
		}
		return productList;
	}
	
	
	// 모든상품 조회(수경)
	@Override
	public List<Product> findAllProducts() {
		return productRepository.findAllProducts();
	}
	
	// 상품아이디에 해당하는 모든 상품디테일 조회(수경)
	@Override
	public List<ProductDetail> findProductDetailsByProductId(int productId) {
		return productRepository.findProductDetailsByProductId(productId);
	}

	// 상품검색 (수경)
	@Override
	public List<Product> adminProductSearch(String searchKeyword, String searchCategory) {
		return productRepository.adminProductSearch(searchKeyword, searchCategory);
	}
	
	// 옵션추가 (수경)
	@Override
	public int adminOptionCreate(ProductDetail productDetail) {
		return productRepository.adminOptionCreate(productDetail);
	}
	
	
	
	
	
	
	
	
	// 정렬

	@Override
	public List<ProductSearchDto> alignByNewProduct(int categoryId) {
		return productRepository.alignByNewProduct(categoryId);
	}

	@Override
	public List<ProductSearchDto> alignByPrice(int categoryId, String inOrder) {
		return productRepository.alignByPrice(categoryId, inOrder);
	}


	@Override
	public List<ProductSearchDto> alignByHighReviews(int categoryId) {
		return productRepository.alignByHighReviews(categoryId);
	}

	@Override
	public List<ProductSearchDto> alignByHighSales(int categoryId) {
		return productRepository.alignByHighSales(categoryId);
	}
}