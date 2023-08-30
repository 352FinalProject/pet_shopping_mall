package com.shop.app.product.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import java.util.Map;
import javax.validation.constraints.NotNull;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.dto.ProductSearchDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.entity.ProductImages;

@Mapper
public interface ProductRepository {

	@Select("select * from product_category order by category_id")
	List<ProductCategory> findAll();

	@Select("select * from product_category where category_id = #{categoryId}")
	ProductCategory findProductCategoryById(int categoryId);

	@Insert("insert into product(product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt) values (seq_product_id.nextval, #{categoryId}, #{productName}, #{productPrice}, #{imageId}, default, null, default, default)")
	@SelectKey(
			before = false,
			keyProperty = "productId",
			resultType = int.class,
			statement = "select seq_product_id.currval from dual"
			)
	int insertProduct(Product product);
	
	@Select("select * from product_detail where product_detail_id = #{productDetailId}")
	ProductDetail findProductDetailById(int productDetailId);

	@Select("select * from product_detail order by product_detail_id desc")
	List<ProductDetail> findAllProductDetails();

	@Select("select * from product where product_id = #{productId}")
	Product findProductById(int productId);

	@Update("update product set category_id = #{categoryId}, product_name = #{productName}, product_price = #{productPrice}, image_id = #{imageId} where product_id = #{productId}")
	int updateProduct(Product product);

	@Delete("delete from product where product_id = #{productId}")
	int deleteProduct(int productId);

	@Insert("insert into product_detail values (seq_product_detail_id.nextval, #{productId, jdbcType=INTEGER}, #{optionName, jdbcType=VARCHAR}, #{optionValue, jdbcType=VARCHAR}, #{additionalPrice, jdbcType=INTEGER}, #{saleState, jdbcType=INTEGER})")
	@SelectKey(
			before = false,
			keyProperty = "productDetailId",
			resultType = int.class,
			statement = "select seq_product_detail_id.currval from dual"
			)
	int insertProductDetail(ProductDetail productDetail);

	// 상품 아이디를 통해 이미지 아이디 조회해서 가져오기
	
	
	// 상품이미지 조회
	ProductImages findImageAttachmentsByProductId(int productId);

	// 상품 이미지 파일 저장
	@Insert("insert into image_attachment (image_id, image_type, image_original_filename, image_renamed_filename, image_file_size, image_created_at) values(seq_image_attachment_id.nextval, #{imageType}, #{imageOriginalFilename}, #{imageRenamedFilename}, #{imageFileSize}, default)")
	@SelectKey(
			before = false,
			keyProperty = "imageId",
			resultType = int.class,
			statement = "select seq_image_attachment_id.currval from dual"
			)
	int insertAttachment(ImageAttachment attach);

	// 상품 ID와 이미지 ID를 사용하여 매핑 정보를 DB에 저장
	@Insert("insert into image_attachment_mapping (mapping_id, ref_table, ref_id, image_id) VALUES (seq_image_attachment_mapping_id.nextval, 'product', #{refId}, #{imageId})")
	int insertMapping(int refId, int imageId);

	@Select("select * from product_detail where product_id = #{productId}")
	List<ProductDetail> findAllProductDetailsByProductId(int productId);

	@Insert("update product_detail set option_name = #{optionName}, option_value = #{optionValue}, additional_price = #{additionalPrice}, sale_state = #{saleState} where product_detail_id = #{productDetailId}")
	int updateProductDetail(ProductDetail productDetail);

	@Delete("delete from product_detail where product_detail_id = #{productDetailId}")
	int deleteProductDetail(int productDetailId);

	@Update("update product set image_id = #{imageId} where product_id = #{productId}")
	int updateImageIdByProductId(int productId, int imageId);

	@Select("select * from product")
	List<Product> findProduct();

	
	@Select("select * from product where category_id = #{categoryId}")
	List<Product> findProductsByCategoryId(int categoryId);

	/* 좋아요 개수 증감 (선모) */
	@Update("UPDATE product SET LIKE_CNT = NVL(LIKE_CNT, 0) + #{cnt} WHERE PRODUCT_ID  = #{productId}")
	int updateLikeCnt(Map<String, Object> param);

	
	List<ProductSearchDto> searchProducts(String searchQuery);

	@Select("select * from product order by 1")
	List<Product> findAllProducts();

	@Select("select * from product_detail where product_id = #{productId} order by 1")
	List<ProductDetail> findProductDetailsByProductId(int productId);

	// (수경)
	@Select("select * from product where product_name like '%' || #{searchKeyword} || '%'")
	List<Product> adminProductSearch(String searchKeyword, String searchCategory);

}