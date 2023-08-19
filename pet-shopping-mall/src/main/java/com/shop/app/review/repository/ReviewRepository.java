package com.shop.app.review.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.shop.app.common.entity.imageAttachment;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;

@Mapper
public interface ReviewRepository {

	// 리뷰작성
	@Insert("insert into review (review_id, review_member_id, review_star_rate, review_title, review_content, review_created_at) values(seq_review_id.nextval, #{reviewMemberId}, #{reviewStarRate}, #{reviewTitle}, #{reviewContent}, default)")
	@SelectKey(
			before = false, 
			keyProperty = "reviewId", 
			resultType = int.class,
			statement = "select seq_review_id.currval from dual")
	int insertReview(Review review);

	// 리뷰 파일첨부
	int insertAttachment(imageAttachment attach);

	// 리뷰 ID와 이미지 ID를 사용하여 매핑 정보를 DB에 저장
	@Insert("insert into image_attachment_mapping (mapping_id, ref_table, ref_id, image_id) VALUES (seq_image_attachment_mapping_id.nextval, 'review', #{reviewId}, #{imageId})")
	int insertMapping(int reviewId, int imageId);

	
	
	
//	@Select("select count(*) from review")
//	int findTotalReviewCount();
//
	@Select("SELECT * FROM review WHERE review_member_id = #{reviewMemberId} ORDER BY review_id DESC")
//	List<Review> findReviewAll(RowBounds rowBounds);
	List<Review> findReviewAll(String reviewMemberId, RowBounds rowBounds);



	// 리뷰 조회
//	@Select("select * from review where review_member_id = #{reviewMemberId}")
//	Review findReviewMemberById(Review review);

	// 리뷰삭제
	@Delete("delete from review where review_id = #{reviewId}")
	int reviewDelete(int reviewId);
	
	// 리뷰 상세조회
	@Select("select * from review where review_id = #{reviewId}")
	Review findReviewId(Review review);

	// 리뷰 상세조회 - 이미지 조회
	ReviewDetails findImageAttachmentsByReviewId(int reviewId);

	// 리뷰수정
	@Update("update review set review_title = #{reviewTitle}, review_content = #{reviewContent}, review_star_rate = #{reviewStarRate} where review_id = #{reviewId}")
	int updateReview(Review review);

}
