package com.shop.app.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class HelloSpringUtils {

	/**
	 *	yyyyMMdd_HHmmssSSS_123.png
	 *
	 * @param originalFilename
	 * @return
	 */
	public static String getRenameFilename(String originalFilename) {
		
		// 확장자
		String ext = "";
		int dotIndex = originalFilename.lastIndexOf(".");
		if(dotIndex > -1)
			ext = originalFilename.substring(dotIndex); // .jpg
		
		// 형식객체
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000");
		return sdf.format(new Date()) + df.format(Math.random() * 1000) + ext;
	}

}
