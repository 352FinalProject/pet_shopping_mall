package com.shop.app.product.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;

@Mapper
public interface ProductRepository {
	
//	@Select("select * from product where product_code = #{product_code}")
//	Product findProductByCode(String productCode);

	@Insert("insert into product seq_product_id.nextval, #{category_id}, #{product_name}, #{product_price}, #{thumbnail_img}, #{product_img}, default, #{expire_date}, default, default")
	int insertProduct(Product product);

	@Select("select * from product_category order by category_id")
	List<ProductCategory> findAll();
	
	
}
