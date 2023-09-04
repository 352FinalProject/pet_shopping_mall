package com.shop.app.common.dto;

import java.time.LocalDateTime;

import com.shop.app.common.entity.Thumbnail;

import lombok.Data;
@Data
public class ImageCreateDto {
	private String imageOriginalFilename;
	private String imageRenamedFilename;
	private Thumbnail thumbnail;
}
