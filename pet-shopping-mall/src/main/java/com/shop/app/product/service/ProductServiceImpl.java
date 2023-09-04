package com.shop.app.product.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.product.dto.AdminProductDto;
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

	/**
	 *  @author 전수경
	 *  - 상품등록 메서드 (상품정보 + 이미지 등록)
	 */
	@Override
	public int insertProduct(ProductImages productImages) {
		Product product = productImages.toProduct();
		int result = productRepository.insertProduct(product);
		
		// productId = refId
		int productId = product.getProductId();
		
		// 첨부이미지 저장
		List<ImageAttachment> attachments = productImages.getAttachments();
		if(attachments != null && !attachments.isEmpty()) {
			for(ImageAttachment attach : attachments) {
				// 1. 이미지 파일 저장
				int result2 = productRepository.insertAttachment(attach);
				// 2. 이미지파일 DB저장후 생성된 이미지 아이디 가져오기
				int imageId = attach.getImageId(); 
				// 3. 상품 ID와 이미지 ID를 사용하여 매핑 정보를 데이터베이스에 저장
				int result3 = productRepository.insertMapping(productId, imageId);
				
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

	/**
	 * @author 강선모
   	 * -찜 수 증감 
	 */
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

	
	
	
	@Override
	public List<ProductSearchDto> alignProducts(int categoryId, String alignType, String inOrder) {
		return productRepository.alignProducts(categoryId, alignType, inOrder);
	}

	@Override
	public List<Product> findSnackAll(int categoryId) {
		return productRepository.findSnackAll(categoryId);
	}

	@Override
	public List<Product> findFashionAll(int _categoryId) {
		return productRepository.findFashionAll(_categoryId);
	}

	@Override
	public int findTotalProductCountByCategory(int categoryId) {
		return productRepository.findTotalProductCountByCategory(categoryId);
	}


	@Override
	public List<ProductSearchDto> searchProductsById(Map<String, Object> params) {
		int limit = (int) params.get("limit");
		int page = (int) params.get("page");
		int offset = (page - 1) * limit;
		int categoryId = (int) params.get("categoryId");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return productRepository.searchProductsById(rowBounds, categoryId);
	}

	@Override
	public List<AdminProductDto> findProductsAll() {
		List<AdminProductDto> products = productRepository.findProductsAll();
		return productRepository.findProductsAll();
	}

	@Override
	public List<ProductSearchDto> searchHomeProductsById(int categoryId) {
		return productRepository.searchHomeProductsById(categoryId);
	}

	@Override
	public List<AdminProductDto> findAdminProductsBySearch(String searchKeyword) {
		return productRepository.findAdminProductsBySearch(searchKeyword);
	}
}