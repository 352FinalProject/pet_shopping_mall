package com.shop.app.petcare.entity;

import java.util.List;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.common.entity.ImageAttachmentMapping;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class PetcareDetails extends Petcare {
	
	private List<ImageAttachment> attachments;
	private List<ImageAttachmentMapping> attachmentMapping;

}
