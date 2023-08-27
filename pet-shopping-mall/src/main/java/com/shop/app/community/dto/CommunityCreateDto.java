package com.shop.app.community.dto;

import java.sql.Date;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;

import com.shop.app.community.entity.Community;
import com.shop.app.review.dto.ReviewCreateDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class CommunityCreateDto {
	
//	private int communityId;
//	
//	@NotBlank(message = "게시글 제목을 입력해주세요.")
//	private String communityTitle;
//	
//	@NotBlank(message = "게시글 내용을 입력해주세요.")
//	private String communityContent;
//	
//	private LocalDateTime communityCreatedAt;
//	
//	private int imageId;
//	
//	public Community toCommunity() {
//		return Community.builder()
//				.communityId(communityId)
//				.communityTitle(communityTitle)
//				.communityContent(communityContent)
//				.communityCreatedAt(communityCreatedAt)
//				.build();
//	}
	

}
