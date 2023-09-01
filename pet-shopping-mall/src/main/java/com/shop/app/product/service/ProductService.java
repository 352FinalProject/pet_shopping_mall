package com.shop.app.product.service;

import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotNull;

import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.dto.ProductSearchDto;
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
	
	// 찜 수 증감 (선모)
	int updateLikeCnt(Map<String, Object> param);
	
	// index페이지 상품 검색 담희
	List<ProductSearchDto> searchProducts(String searchQuery);

	// 모든 상품 조회(수경)
	List<Product> findAllProducts();
	
	// 상품아이디로 모든 상품디테일 조회(수경)
	List<ProductDetail> findProductDetailsByProductId(int productId);

	// 상품검색 (수경)
	List<Product> adminProductSearch(String searchKeyword, String searchCategory);

	// 옵션추가 (수경)
	int adminOptionCreate(ProductDetail productDetail);
	
	
	// 상품 조회 정렬 (담희)
	List<ProductSearchDto> alignByNewProduct(int categoryId);
	List<ProductSearchDto> alignByPrice(int categoryId, String inOrder);
	List<ProductSearchDto> alignByHighReviewStar(int categoryId);
	List<ProductSearchDto> alignByReviewCnt(int categoryId);
	
	// 인덱스 페이지 간식 불러오기 (예라)
	List<Product> findSnackAll(int categoryId);
	
	// 인덱스 페이지 패션용품 불러오기 (예라)
	List<Product> findFashionAll(int _categoryId);
	List<ProductSearchDto> alignProducts(int id, String alignType, String inOrder);
}