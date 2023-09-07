package com.shop.app.review.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.review.dto.ProductReviewAvgDto;
import com.shop.app.review.dto.ReviewDetailDto;
import com.shop.app.review.dto.ReviewListDto;
import com.shop.app.review.dto.ReviewProductDto;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;

@Mapper
public interface ReviewRepository {

	// 리뷰작성
	@Insert("insert into review (review_id, pet_id, order_id, product_id, review_member_id, product_detail_id, review_star_rate, review_title, review_content, review_created_at) values(seq_review_id.nextval, #{petId, jdbcType=INTEGER}, #{orderId}, #{productId}, #{reviewMemberId, jdbcType=VARCHAR}, #{productDetailId}, #{reviewStarRate}, #{reviewTitle, jdbcType=VARCHAR}, #{reviewContent, jdbcType=VARCHAR}, default)")
	@SelectKey(
			before = false, 
			keyProperty = "reviewId", 
			resultType = int.class,
			statement = "select seq_review_id.currval from dual")
	int insertReview(Review review);

	// 리뷰 파일첨부
	int insertAttachment(ImageAttachment attach);

	// 리뷰 ID와 이미지 ID를 사용하여 매핑 정보를 DB에 저장
	@Insert("insert into image_attachment_mapping (mapping_id, ref_table, ref_id, image_id) VALUES (seq_image_attachment_mapping_id.nextval, 'review', #{reviewId}, #{imageId})")
	int insertMapping(int reviewId, int imageId);

	// 내가 쓴 리뷰 조회
	List<ReviewListDto> findReviewAll(String reviewMemberId, RowBounds rowBounds);

	// 리뷰 전체 카운트
	@Select("select count (*) from review where review_member_id = #{reviewMemberId, jdbcType=VARCHAR}")
	int findTotalReviewCount(String reviewMemberId);

	// 리뷰삭제
	@Delete("delete from review where review_id = #{reviewId}")
	int reviewDelete(int reviewId);
	
	// 리뷰 상세조회
	@Select("select * from review where review_id = #{reviewId}")
	Review findReviewId(int reviewId);

	// 리뷰 상세조회 - 이미지 조회
	ReviewDetails findImageAttachmentsByReviewId(int reviewId);
	
	// 리뷰 상세조회 - 상품조회
	ReviewProductDto findProductReviewId(int reviewId);

	// 리뷰수정
	@Update("update review set review_title = #{reviewTitle}, review_content = #{reviewContent}, review_star_rate = #{reviewStarRate} where review_id = #{reviewId}")
	int updateReview(Review review);

	@Select("select * from review where review_id = #{reviewId}")
	ReviewDetails getDeleteReviewById(int reviewId);

	// 상품 상세페이지 리뷰 전체 카운트
	@Select("select count(*) from review where product_id = #{productId}")
	int findProductTotalReviewCount(int productId);
	
	// 상품 상세페이지 전체 리뷰
	@Select("select * from review where product_id = #{productId} order by review_created_at desc")
	List<Review> findProductReviewAll(RowBounds rowBounds, int productId);

	// 상품 상세페이지 - 리뷰 상세조회 - 이미지 조회
	ReviewDetails findProductImageAttachmentsByReviewId(int reviewId);

	ReviewDetails findImageAttachmentsByReviewMemberId(int reviewId);

	String findImageFilenameByReviewId(int reviewId2);

	@Select("select * from review where review_id = #{reviewId}")
	Review findPoductListReviewId(int reviewId);

	// 상품 디테일 - 리뷰 전체개수 확인
	@Select("select count (*) from review where product_id = #{productId}")
	int findReviewTotalCount(int productId);

	// 상품 - 리뷰 평점
	ProductReviewAvgDto productReviewStarAvg(int productId);

	@Select("select * from review where product_id = #{productId}")
	List<ProductReviewAvgDto> findProductReviewAvgAll(int productId);

	// 상품 리스트 - 리뷰 전체개수 확인
	@Select("select count(*) from review where product_id = #{productId}")
	int findProductListReviewTotalCount(int productId);

	// 별점 퍼센트 구하기 위한 전체 리뷰
	@Select("select * from review where product_id = #{productId}")
	List<Review> findProductReviewAllNoPageBar(int productId);

	ReviewDetails findProductImageAttachmentsByReviewId2(@Param("reviewId")int reviewId2, @Param("orderId")int orderId);
//	ReviewDetails findProductImageAttachmentsByReviewId2(int reviewId2);

	
	
	




}
