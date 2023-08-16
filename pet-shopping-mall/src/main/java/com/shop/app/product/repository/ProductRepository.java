package com.shop.app.product.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.product.entity.Product;

@Mapper
public interface ProductRepository {
	
	@Select("select * from product where product_code = #{product_code}")
	Product findProductByCode(String productCode);

	@Insert("insert into product values ()")
	int insertProduct(Product product);
	
	
}
