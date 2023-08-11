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
public class Attachment {
	
	private int id;
	private int imageType;
	private int itemId;
	private String originalFilename;
	private String renamedFilename;
	private Thumbnail thumbnail;
	private Long fileSize;
	private LocalDateTime createdAt;
	private IsDeleted isDeleted;
	
}
