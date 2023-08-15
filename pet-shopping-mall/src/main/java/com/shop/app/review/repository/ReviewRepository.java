package com.shop.app.review.repository;

import java.util.List;

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
	@Insert("insert into image_attachment values(seq_image_attachment_id.nextval, #{imageType}, #{imageCategory}, #{imageOriginalFilename}, #{imageRenamedFilename}, #{imageFileSize}, default)")
	int insertAttachment(imageAttachment attach);

//	@Select("select count(*) from review")
//	int findTotalReviewCount();

	//@Select
//	List<Review> findReviewAll(RowBounds rowBounds);

	@Insert("insert into image_attachment_mapping (mapping_id, ref_table, ref_id, image_id) VALUES (seq_image_attachment_mapping_id.nextval, 'review', #{reviewId}, #{imageId})")
	int insertMapping(int refId, int imageId);

	@Select("select * from review where review_member_id = #{reviewMemberId}")
	Review findReviewMemberById(Review review);

}
