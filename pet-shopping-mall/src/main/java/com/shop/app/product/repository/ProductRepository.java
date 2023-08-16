package com.shop.app.product.repository;

import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotNull;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.product.dto.ProductPriceDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductDetail;

@Mapper
public interface ProductRepository {
	
	@Select("select * from product where product_code = #{productCode}")
	Product findProductByCode(String productCode);

	@Select("select * from product_detail where product_detail_id = #{productDetailId}")
	ProductDetail findProductDetailById(int productDetailId);

}
