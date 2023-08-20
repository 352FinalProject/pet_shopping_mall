package com.shop.app.common;

import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;

@Service
public class ImageService {

    // 이미지가 저장된 경로
    private String uploadPath = "D:/hyelyung_workspace/workspace/spring_workspace/spring/hello-springboot/src/main/webapp/resources/upload/review/";

    public Resource loadImage(Long reviewId, String filename) {
        Path imagePath = Paths.get(uploadPath, reviewId.toString(), filename);
        try {
            Resource resource = new UrlResource(imagePath.toUri());
            if (resource.exists() && resource.isReadable()) {
                return resource;
            } else {
                throw new RuntimeException("Could not read the image file");
            }
        } catch (MalformedURLException e) {
            throw new RuntimeException("Error loading image: " + e.getMessage());
        }
    }
}






