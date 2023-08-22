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

import com.shop.app.product.dto.ProductPriceDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;

@Mapper
public interface ProductRepository {

	@Select("select * from product_category order by category_id")
	List<ProductCategory> findAll();

	@Select("select * from product_category where category_id = #{categoryId}")
	ProductCategory findProductCategoryById(int categoryId);

	@Insert("insert into product(product_id, category_id, product_name, product_price, img_id, create_date, expire_date, like_cnt, view_cnt) values (seq_product_id.nextval, #{categoryId}, #{productName}, #{productPrice}, #{imgId}, default, null, default, default)")
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




}
