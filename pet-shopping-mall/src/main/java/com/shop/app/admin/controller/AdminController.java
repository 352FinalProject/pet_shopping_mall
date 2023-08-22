package com.shop.app.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.shop.app.admin.service.AdminService;
import com.shop.app.common.HelloSpringUtils;
import com.shop.app.common.entity.imageAttachment;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.member.entity.Subscribe;

import com.shop.app.order.dto.OrderAdminListDto;
import com.shop.app.order.service.OrderService;

import com.shop.app.product.dto.ProductCreateDto;
import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.dto.ProductUpdateDto;
import com.shop.app.product.entity.Product;

import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Validated
@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ProductService productService;
	
	@GetMapping("/admin.do")
	public void admin() {}
	
	@GetMapping("/index.do")
	public void admin2() {}
	
	/**
	 * 회원목록
	 * @param page
	 * @param model
	 */
	@GetMapping("/adminMemberList.do")
	public void adminMemberList(Model model) {
		List<MemberDetails> members = adminService.adminMemberList();
		log.debug("members = {}", members);
		
		// EnumTypeHandler 사용하여 enum 값 매핑
	    for (MemberDetails member : members) {
	        
	        String subscribeString = member.getSubscribe().toString(); 
	        Subscribe subscribe = Subscribe.valueOf(subscribeString); 
	        
	        member.setSubscribe(subscribe);
	    }
	    int totalCount = adminService.findTotalAdminCount();
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("members", members);
	}
	
	/**
	 * 구독자목록
	 * @param page
	 * @param model
	 */
	@GetMapping("/adminSubscribeList.do")
	public void adminSubscribeList(Model model) {
		List<MemberDetails> subscribedMembers = adminService.adminSubscribeList();
//		log.debug("members = {}", members);
		
		// EnumTypeHandler 사용하여 enum 값 매핑
	    for (MemberDetails subscribedMember : subscribedMembers) {
	        
	        String subscribeString = subscribedMember.getSubscribe().toString(); 
	        Subscribe subscribe = Subscribe.valueOf(subscribeString); 
	        
	        subscribedMember.setSubscribe(subscribe);
	    }
	    
	    int totalCount = adminService.findTotalubscribeCount();
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("subscribedMembers", subscribedMembers);
	}
	

	/**
	 *  관리자 1:1 문의 전체 내역 조회 + 페이징바 (예라)
	 * @param page
	 * @param question
	 * @param model
	 */
	@GetMapping("/adminQuestionList.do")
	public void adminQuestionList(@RequestParam(defaultValue = "1") int page, Question question, Model model) {
		int limit = 5;
		
		Map<String, Object> params = Map.of(
				"page", page,
				"limit", limit
			);
		
		int totalCount = adminService.findTotalQuestionCount();
		int totalPages = (int) Math.ceil((double) totalCount / limit);
		model.addAttribute("totalPages", totalPages);
		
		List<Question> questions = adminService.findQuestionAll(params);
		log.debug("params = {}", params);
		log.debug("questions = {}", questions);
		model.addAttribute("questions", questions);
	}
	
	
	/**
	 *  관리자 1:1 문의 제목, 내용 검색 (예라)
	 * @param searchKeyword
	 * @param model
	 * @return
	 */
	@GetMapping("/adminQuestionSearch.do")
	public String questionSearch(
	        @RequestParam(required = false) String searchKeyword,
	        Model model) {

	    if (searchKeyword != null && !searchKeyword.isEmpty()) {
	        List<Question> questions = adminService.questionSearch(searchKeyword);

	        for (Question question : questions) {
		        String titleString = question.getQuestionTitle(); 
		        String contentString = question.getQuestionContent(); 
		        
	        	question.setQuestionTitle(titleString); 
	        	question.setQuestionContent(contentString);
		    }
	        model.addAttribute("questions", questions);
	    }
	    return "admin/adminQuestionList";
	}
	
	/**
	 *  전체회원 이름,아이디 검색
	 * @param searchKeyword
	 * @param model
	 * @return
	 */
	@GetMapping("/adminMemberSearchByNameOrId.do")
	public String adminMemberSearchByNameOrId(
	        @RequestParam(required = false) String searchKeyword,
	        Model model) {
	    if (searchKeyword != null && !searchKeyword.isEmpty()) {
	        List<MemberDetails> members = adminService.adminMemberSearchByNameOrId(searchKeyword);
	        
	        for (MemberDetails member : members) {
		        String subscribeString = member.getSubscribe().toString(); 
		        Subscribe subscribe = Subscribe.valueOf(subscribeString);
		        
		        member.setSubscribe(subscribe);
		    }
			model.addAttribute("members", members);
	    }
	    int totalCount = adminService.findTotalAdminCount();
	    model.addAttribute("totalCount", totalCount);
	    
	    return "admin/adminMemberList";
	}
	
	/**
	 *  구독자 이름,아이디 검색
	 * @param searchKeyword
	 * @param page
	 * @param model
	 * @return
	 */
	@GetMapping("/adminSubscribeSearchByNameOrId.do")
	public String adminSubscribeSearchByNameOrId(
	        @RequestParam(required = false) String searchKeyword,
	        Model model) {
		
	    if (searchKeyword != null && !searchKeyword.isEmpty()) {
	        List<MemberDetails> members = adminService.adminSubscribeSearchByNameOrId(searchKeyword);
	        List<MemberDetails> subscribedMembers = new ArrayList<>();
	        for (MemberDetails member : members) {
		        
		        String subscribeString = member.getSubscribe().toString(); 
		        Subscribe subscribe = Subscribe.valueOf(subscribeString);
		        
		        member.setSubscribe(subscribe);
	        
		        if (member.getSubscribe() == Subscribe.Y) {
	                subscribedMembers.add(member);
		        }
	        }
	        model.addAttribute("subscribedMembers", subscribedMembers);
	    }
	    int totalCount = adminService.findTotalubscribeCount();
	    model.addAttribute("totalCount", totalCount);
			
	    return "admin/adminSubscribeList";
	}
	
	/**
	 * 주문 조회
	 * @param model
	 */
	@GetMapping("/adminOrderList.do")
	public void adminOrderList(Model model) {
		List<OrderAdminListDto> orderlists = orderService.adminOrderList();
		model.addAttribute("orderlists", orderlists);
		String[] method = {"카카오", "신용카드"};
		String[] status = {"결제대기", "결제완료", "배송준비", "배송중", "배송완료", "주문취소", "환불" , "반품"};
		model.addAttribute("method", method);
		model.addAttribute("status", status);
	}
	
	/**
	 * 주문검색 조회
	 * @param model
	 */
	@GetMapping("/adminOrderSearch.do")
	@ResponseBody
	public List<OrderAdminListDto> adminOrderSearch(
			@RequestParam(required = false) String searchKeyword,
	        @RequestParam(required = false) String startDate,
	        @RequestParam(required = false) String endDate,
	        @RequestParam(required = false) List<String> _paymentMethod,
	        @RequestParam(required = false) List<String> orderStatus,
				Model model) {
		
		List<String> methodList = Arrays.asList("카카오", "신용카드");
		System.out.println(methodList.toString());
		List<String> paymentMethod = Arrays.asList(_paymentMethod);
		
		String[] status = {"결제대기", "결제완료", "배송준비", "배송중", "배송완료", "주문취소", "환불" , "반품"};
	    
		
		for (String payment : paymentMethod) {
	        int index = methodList.indexOf(payment); // Find the index of payment in the method list
	        System.out.println(index);
	    }
		
		
		
//		/*
//		 * List<OrderAdminListDto> orderlists =
//		 * orderService.adminOrderSearch(searchKeyword, startDate, endDate,
//		 * paymentMethod, orderStatus);
//		 */
		return null;
	}
	
	
	
//	/**
//	 * 상품정보 조회 
//	 * 
//	 * @param member
//	 * @param model
//	 */
//	@GetMapping("/adminProductList.do")
//	public void adminProductList(
//		@AuthenticationPrincipal MemberDetails member,
//		Model model
//			) {
//		log.debug("member = {}", member);
//		
//		// 기본 상품들 조회해서 가져오기.
//		List<Product> basicProducts = productService.findAllBasicProduct();
//		log.debug("basicProducts = {}", basicProducts);
//		model.addAttribute("basicProducts", basicProducts);
//	}
	
	/**
	 * 상품별 판매량통계
	 */
	@GetMapping("/adminStatisticsProduct.do")
	public void adminStatisticsProduct() {
		
		
	}
	
	
	/**
	 * 월별 판매량통계
	 */
	@GetMapping("/adminStatisticsMonthly.do")
	public void adminStatisticsMonthly() {
		
		
	}
	
	/**
	 * 일별 판매량통계
	 */
	@GetMapping("/adminStatisticsDaily.do")
	public void adminStatisticsDaily() {
		
		
	}
	
	
	/**
	 * @author 전수경
	 * 상품정보 조회 
	 */
	@GetMapping("/adminProductList.do")
	public void adminProductList(
		@AuthenticationPrincipal MemberDetails member,
		Model model
			) {
		// 등록된 상품 가져오기
		List<ProductDetail> productDetails = productService.findAllProductDetails();
		log.debug("productDetails = {}", productDetails);
		
		List<ProductInfoDto> productInfos = new ArrayList<ProductInfoDto>();
		for(ProductDetail productDetail : productDetails) {
			Product product = productService.findProductById(productDetail.getProductId());
			ProductCategory productCategory = productService.findProductCategoryById(product.getCategoryId());
			// 옵션값
			ProductInfoDto productInfo = ProductInfoDto.builder()
					.product(product)
					.productCategory(productCategory)
					.productDetailId(productDetail.getProductDetailId())
					.optionName(productDetail.getOptionName())
					.optionValue(productDetail.getOptionValue())
					.additionalPrice(productDetail.getAdditionalPrice())
					.saleState(productDetail.getSaleState())
					.build();
			// 리스트에 추가
			productInfos.add(productInfo);
		}
		
		log.debug("productInfos = {}", productInfos);
		model.addAttribute("productInfos", productInfos);
	}
	

	
	/**
	 * @author 전수경
	 * - 상품등록 폼으로 이동
	 */
	@GetMapping("/adminProductDetailCreate.do")
	public void adminProductDetailCreate(
			@AuthenticationPrincipal MemberDetails member, 
			Model model
			) {
		// 상품카테고리 조회 후 전달
		List<ProductCategory> categories = productService.findAll();
		model.addAttribute("categories", categories);
	}

	/**
	 * @author 전수경
	 * - 상품등록
	 */
	@PostMapping("/adminProductDetailCreate.do")
	public String adminProductDetailCreate(
			@Valid ProductCreateDto _product,
			@AuthenticationPrincipal MemberDetails member, 
			Model model,
			@RequestParam(value="upFile", required= false) List<MultipartFile> upFiles) throws IllegalStateException, IOException {

		// 1. 파일저장
		List<imageAttachment> attachments = new ArrayList<>();
		boolean hasImage = false; // 이미지 있는지 확인하는 변수 (예라)

		for(MultipartFile upFile : upFiles) {
			if(!upFile.isEmpty()) {
				String imageOriginalFilename = upFile.getOriginalFilename();
				String imageRenamedFilename = HelloSpringUtils.getRenameFilename(imageOriginalFilename);
				File destFile = new File(imageRenamedFilename);
				upFile.transferTo(destFile);

				int imageType = 1;

				imageAttachment attach =
						imageAttachment.builder()
						.imageOriginalFilename(imageOriginalFilename)
						.imageRenamedFilename(imageRenamedFilename)
						.imageType(imageType)
						.imageFileSize(upFile.getSize())
						.build();

				attachments.add(attach);
				hasImage = true; // 이미지가 있으면 true 
			}
		}

		// 2. db저장
		// 2.1. product 객체 저장
		Product product = Product.builder()
				.build(); // 상품카테고리아이디, 상품명, 가격
		int result = productService.insertProduct(product);
		int productId = product.getProductId();
		log.debug("productId = {}", productId);
		// 2.1. productDetail 객체 저장
		ProductDetail productDetail = ProductDetail.builder()
				.productId(productId)
				.optionName(_product.getOptionName())
				.optionValue(_product.getOptionValue())
				.additionalPrice(_product.getAdditionalPrice())
				.saleState(_product.getSaleState())
				.attachments(attachments)
				.build();
		result = productService.insertProductDetail(productDetail);
		int productDetailId = productDetail.getProductDetailId();
		log.debug("productDetailId = {}", productDetailId);
		
		return "redirect:/admin/adminProductList.do";
	}
	
	/**
	 * @author 전수경
	 * 상품수정 폼으로 연결
	 */
	@GetMapping("/adminProductDetailUpdate.do")
	public void adminProductDetailUpdate(
			@RequestParam int productId,
			@AuthenticationPrincipal MemberDetails member, 
			Model model
			) {
		
		// 상품카테고리 조회 후 전달
		List<ProductCategory> categories = productService.findAll();
		model.addAttribute("categories", categories);
		
		// 상품아이디로 상품정보 조회해서 가져오기
		ProductDetail product = productService.findProductDetailById(productId);
		log.debug("product = {}", product);
		model.addAttribute("product", product);
	}
	
	
	/**
	 * @author 전수경
	 * 상품 수정
	 */
	@PostMapping("/adminProductDetailUpdate.do")
	public String adminProductDetailUpdate(
			@Valid ProductUpdateDto _product,
			BindingResult bindingResult,
			@AuthenticationPrincipal MemberDetails member, 
			Model model
			) {
		log.debug("ProductUpdateDto = {}", _product);
		Product product = _product.toProduct();

		
		// 상품정보 수정하기
		int result = productService.updateProduct(product);
		log.debug("product = {}", product);
		model.addAttribute("product", product);
		
		return "redirect:/admin/adminProductList.do";
	}
	
	/**
	 * @author 전수경
	 * 상품 삭제
	 */
	@PostMapping("/adminProductDetailDelete.do")
	public String adminDeleteProduct(
			@Valid ProductUpdateDto _product,
			BindingResult bindingResult,
			@AuthenticationPrincipal MemberDetails member, 
			Model model
			){
		
		Product product = _product.toProduct();
		int productId = product.getProductId();
		int result = productService.deleteProduct(productId);
		
		return "redirect:/admin/adminProductList.do";
	}



	/**
	 * 시간남으면하는기능(포인트주입)
	 */
//	@PostMapping("/adminPointUpdate.do")
//	public String adminPointUpdate(
//			@RequestParam String memberId,
//	        @RequestParam int pointChange) {
//	    adminService.updateMemberPoints(memberId, pointChange);
//		return "admin/adminMemberList";
//	}

}



