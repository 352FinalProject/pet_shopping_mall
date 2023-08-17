package com.shop.app.review.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.shop.app.common.entity.imageAttachment;
import com.shop.app.review.entity.Review;
import com.shop.app.review.entity.ReviewDetails;

@Mapper
public interface ReviewRepository {

	// 리뷰작성
	@Insert("insert into review (review_id, review_member_id, review_star_rate, review_title, review_content, review_created_at) values(seq_review_id.nextval, #{reviewMemberId}, #{reviewStarRate}, #{reviewTitle}, #{reviewContent}, default)")
	int insertReview(Review review);

	// 리뷰 파일첨부
	int insertAttachment(imageAttachment attach);

	// 리뷰 ID와 이미지 ID를 사용하여 매핑 정보를 DB에 저장
	@Insert("insert into image_attachment_mapping (mapping_id, ref_table, ref_id, image_id) VALUES (seq_image_attachment_mapping_id.nextval, 'review', #{reviewId}, #{imageId})")
	int insertMapping(int reviewId, int imageId);

	
	
	
//	@Select("select count(*) from review")
//	int findTotalReviewCount();
//
//	@Select
//	List<Review> findReviewAll(RowBounds rowBounds);


	// 리뷰 조회
	@Select("select * from review where review_member_id = #{reviewMemberId}")
	Review findReviewMemberById(Review review);

	// 리뷰삭제
	@Delete("delete from review where review_id = #{reviewId}")
	int reviewDelete(int reviewId);
	
	// 리뷰조회2
	@Select("select * from review")
	Review findReviewId(Review review);

}
