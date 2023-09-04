package com.shop.app;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.app.order.service.OrderService;
import com.shop.app.product.dto.ProductSearchDto;
import com.shop.app.product.service.ProductService;
import com.shop.app.review.service.ReviewService;



@Controller
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
	    final int fashionCategoryId = 3;

	    List<ProductSearchDto> snackProductInfos = processProductCategory(snackCategoryId);
	    List<ProductSearchDto> fashionProductInfos = processProductCategory(fashionCategoryId);

	    model.addAttribute("snackProductInfos", snackProductInfos);
	    model.addAttribute("fashionProductInfos", fashionProductInfos);

	    return "forward:/index.jsp";
	}

	private List<ProductSearchDto> processProductCategory(int categoryId) {
		List<ProductSearchDto> productInfos = productService.searchHomeProductsById(categoryId);
		return productInfos;
	}
}
