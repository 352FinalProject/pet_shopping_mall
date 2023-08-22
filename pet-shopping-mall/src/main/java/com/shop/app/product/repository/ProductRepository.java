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

import com.shop.app.common.entity.imageAttachment;
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

	@Update("update product set category_id = #{categoryId}, product_name = #{productName}, product_price = #{productPrice}, img_id = #{imgId}, expire_date = #{expireDate} where product_id = #{productId}")
	int updateProduct(Product product);

	@Delete("delete from product where product_id = #{productId}")
	int deleteProduct(int productId);

	@Insert("insert into product_detail(product_detail_id, product_id, option_name, option_value, additional_price,sale_state) values (seq_product_detail_id.nextval, #{productId}, #{optionName}, #{optionValue}, #{additionalPrice}, #{saleState})")
	@SelectKey(
			before = false,
			keyProperty = "productDetailId",
			resultType = int.class,
			statement = "select seq_product_detail_id.currval from dual"
			)
	int insertProductDetail(ProductDetail productDetail);

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
	int insertAttachment(imageAttachment attach);

	// 상품 ID와 이미지 ID를 사용하여 매핑 정보를 DB에 저장
	@Insert("insert into image_attachment_mapping (mapping_id, ref_table, ref_id, image_id) VALUES (seq_image_attachment_mapping_id.nextval, 'product', #{refId}, #{imageId})")
	int insertMapping(int refId, int imageId);

	@Select("select * from product_detail where product_id = #{productId}")
	List<ProductDetail> findAllProductDetailsByProductId(int productId);


}
