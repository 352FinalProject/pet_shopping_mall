package com.shop.app.product.repository;

import java.util.List;
import org.apache.ibatis.annotations.Insert;
import java.util.Map;
import javax.validation.constraints.NotNull;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import com.shop.app.product.dto.ProductPriceDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;

@Mapper
public interface ProductRepository {
	
//	@Select("select * from product where product_code = #{product_code}")
//	Product findProductByCode(String productCode);

	@Insert("insert into product seq_product_id.nextval, #{category_id}, #{product_name}, #{product_price}, #{thumbnail_img}, #{product_img}, default, #{expire_date}, default, default")
	int insertProduct(Product product);

	@Select("select * from product_category order by category_id")
	List<ProductCategory> findAll();
	
	
	@Select("select * from product where product_code = #{productCode}")
	Product findProductByCode(String productCode);

	@Select("select * from product_detail where product_detail_id = #{productDetailId}")
	ProductDetail findProductDetailById(int productDetailId);


}
