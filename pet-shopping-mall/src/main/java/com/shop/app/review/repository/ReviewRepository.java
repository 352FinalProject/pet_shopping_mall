package com.shop.app.review.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.shop.app.common.entity.imageAttachment;
import com.shop.app.review.dto.ReviewDetails;
import com.shop.app.review.entity.Review;

@Mapper
public interface ReviewRepository {

	// 리뷰작성
	//@Insert()
	int insertReview(Review review);

	// 리뷰 파일첨부
	@Insert("insert into image_attachment values(seq_image_attachment_image_id.nextval, #{imageType}, #{imageCategory}, #{imageOriginalFilename}, #{imageRenamedfilename}, #{imageFileSize}, default)")
	int insertAttachment(imageAttachment attach);

	@Select("select count(*) from review")
	int findTotalReviewCount();

	//@Select
	List<Review> findReviewAll(RowBounds rowBounds);

}
