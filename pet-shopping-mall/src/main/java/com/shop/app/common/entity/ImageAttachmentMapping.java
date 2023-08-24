package com.shop.app.common.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ImageAttachmentMapping {
	private int mappingId;
	private String refTable;
	private int refId;
	private int imageId;
	
}
