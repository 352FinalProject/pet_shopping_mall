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
	
	private int imageId;
	private int imageType;
	private int imageCategory;
	private String imageOriginalFilename;
	private String imageRenamedfilename;
	private Long imageFileSize;
	private LocalDateTime imageCreatedAt;
	
}
