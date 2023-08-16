package com.shop.app.product.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.member.entity.MemberDetails;
import com.shop.app.product.dto.ProductCreateDto;
import com.shop.app.product.entity.Product;
import com.shop.app.product.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Validated
@RequestMapping("/product")
@Controller
public class ProductController {
	
	@Autowired
	private ProductService productService;

	@GetMapping("/productDetail.do")
	public void productDetail() {}
	
	@GetMapping("/productList.do")
	public void productList() {
		
	}
	
	@GetMapping("/addProduct.do")
	public void addProduct() {
		
	}
	
	@PostMapping("/addProduct.do")
	public String addProduct(
			@Valid ProductCreateDto _product,
			BindingResult bindingResult,
			@AuthenticationPrincipal MemberDetails member,
			Model model){
		log.debug("ProductCreateDto = {}", _product);
		
		Product product = _product.toProduct();
		log.debug("product = {}", product);
		
		int result = productService.insertProduct(product);
		
		
		return "redirect:/admin/adminProductList.do";
	}

	
}
