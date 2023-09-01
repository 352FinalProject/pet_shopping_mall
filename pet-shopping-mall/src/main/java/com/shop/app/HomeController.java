package com.shop.app;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.common.entity.ImageAttachmentMapping;
import com.shop.app.notification.entity.Notification;
import com.shop.app.notification.service.NotificationService;
import com.shop.app.order.service.OrderService;
import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.entity.ProductImages;
import com.shop.app.product.service.ProductService;
import com.shop.app.review.dto.ProductReviewAvgDto;
import com.shop.app.review.service.ReviewService;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class HomeController {

	@Autowired
	private ProductService productService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ReviewService reviewService;

	@GetMapping("/")
	public String home(Model model) {

	    final int snackCategoryId = 2;
	    final int fashionCategoryId = 1;

	    List<Product> productSnack = productService.findSnackAll(snackCategoryId);
	    List<Product> productFashion = productService.findFashionAll(fashionCategoryId);
	    List<ProductInfoDto> snackProductInfos = new ArrayList<>();
	    List<ProductInfoDto> fashionProductInfos = new ArrayList<>();

	    processProductCategory(productSnack, snackProductInfos);
	    processProductCategory(productFashion, fashionProductInfos);

	    model.addAttribute("snackProductInfos", snackProductInfos);
	    model.addAttribute("fashionProductInfos", fashionProductInfos);

	    return "forward:/index.jsp";
	}

	private void processProductCategory(List<Product> products, List<ProductInfoDto> productInfos) {
	    for (Product product : products) {
	        ProductImages productImages = productService.findImageAttachmentsByProductId(product.getProductId());
	        List<ProductDetail> productDetails = productService.findAllProductDetailsByProductId(product.getProductId());

	        int orderCnt = 0;
	        for (ProductDetail productDetail : productDetails) {
	            orderCnt += orderService.findOrderCntByProductId(productDetail.getProductDetailId());
	        }

	        productInfos.add(ProductInfoDto.builder()
	                .product(product)
	                .productDetails(productDetails)
	                .productId(product.getProductId())
	                .orderCnt(orderCnt)
	                .attachments(productImages.getAttachments())
	                .attachmentMapping(productImages.getAttachmentMapping())
	                .build());

	        setReviewInfo(productInfos, product.getProductId());
	    }
	}

	private void setReviewInfo(List<ProductInfoDto> productInfos, int productId) {
	    for (ProductInfoDto productInfo : productInfos) {
	        int productListReviewTotalCount = reviewService.findProductListReviewTotalCount(productId);
	        productInfo.setReviewCnt(productListReviewTotalCount);

	        ProductReviewAvgDto productReviewStarAvg = reviewService.productReviewStarAvg(productId);
	        productInfo.setProductReviewStarAvg(productReviewStarAvg);
	    }
	}
}
