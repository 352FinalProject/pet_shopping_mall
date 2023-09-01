package com.shop.app.common.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ImageAttachment {
	
	private int imageId;
	private int imageType;
	private String imageOriginalFilename;
	private String imageRenamedFilename;
	private Long imageFileSize;
	private Thumbnail thumbnail;
	private LocalDateTime imageCreatedAt;
	
}
