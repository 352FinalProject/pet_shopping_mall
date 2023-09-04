package com.shop.app.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.admin.service.AdminService;
import com.shop.app.common.HelloSpringUtils;
import com.shop.app.common.entity.ImageAttachment;
import com.shop.app.common.entity.Thumbnail;
import com.shop.app.member.entity.MemberDetails;
import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;
import com.shop.app.servicecenter.inquiry.service.QuestionService;
import com.shop.app.member.entity.Subscribe;

import com.shop.app.order.dto.OrderAdminListDto;
import com.shop.app.order.dto.OrderAdminProductStatisticsDto;
import com.shop.app.order.dto.OrderAdminStatisticsByDateDto;
import com.shop.app.order.service.OrderService;
import com.shop.app.product.dto.AdminProductDto;
import com.shop.app.product.dto.ProductCreateDto;
import com.shop.app.product.dto.ProductDeleteDto;
import com.shop.app.product.dto.ProductDetailUpdateDto;
import com.shop.app.product.dto.ProductInfoDto;
import com.shop.app.product.dto.ProductOptionCreateDto;
import com.shop.app.product.dto.ProductOptionDeleteDto;
import com.shop.app.product.dto.ProductSearchDto;
import com.shop.app.product.dto.ProductSearchKeywordDto;
import com.shop.app.product.dto.ProductUpdateDto;
import com.shop.app.product.entity.Product;

import com.shop.app.product.entity.ProductCategory;
import com.shop.app.product.entity.ProductDetail;
import com.shop.app.product.entity.ProductImages;
import com.shop.app.product.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Validated
@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private QuestionService questionService;
	
	
	/**
	 * @author 김대원
	 * 주문목록, 통계 조회
	 */
	@GetMapping("/admin.do")
	public void admin(Model model) {
		List<OrderAdminListDto> orderlists = orderService.adminOrderList();
		model.addAttribute("orderlists", orderlists);
		String[] method = {"카카오", "신용카드"};
		String[] status = {"결제대기", "결제완료", "배송준비", "배송중", "배송완료", "주문취소", "환불" , "반품"};
		model.addAttribute("method", method);
		model.addAttribute("status", status);
		
		List<OrderAdminProductStatisticsDto> priceStatistics = orderService.adminStatisticsPrice();
		model.addAttribute("priceStatistics", priceStatistics);
		
		List<OrderAdminStatisticsByDateDto> dailyStatistics = orderService.adminStatisticsByDaily();
		model.addAttribute("dailyStatistics", dailyStatistics);
		
	}
	
	/**
	 * @author 김대원
	 * 회원목록 조회
	 */
	@GetMapping("/adminMemberList.do")
	public void adminMemberList(Model model) {
		List<MemberDetails> members = adminService.adminMemberList();
		
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
	 * @author 김대원
	 * 구독회원목록 조회
	 */
	@GetMapping("/adminSubscribeList.do")
	public void adminSubscribeList(Model model) {
		List<MemberDetails> subscribedMembers = adminService.adminSubscribeList();
		
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
	 *  관리자 1:1 문의 전체 내역 조회 + 페이징바
	 * @author 전예라
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
		
		List<QuestionDetails> questions = questionService.findQuestionAll(params);
		model.addAttribute("questions", questions);
	}
	
	/**
	 * @author 전예라
	 * 1:1 문의 상세 조회
	 */
	@GetMapping("/adminQuestionDetail.do")
	public void adminQuestionDetail(Question question, Model model) {

	    Question questions = questionService.findQuestionByAnwerCount(question);
	    model.addAttribute("questions", questions);
	    
	    int questionId = question.getQuestionId();

	    Answer answer = Answer
	    		.builder()
	    		.answerQuestionId(questionId)
	    		.build();

	    Answer answers = questionService.findQuestionAnswersById(answer);
	    model.addAttribute("answers", answers);

	    QuestionDetails questionDetails = questionService.findImageAttachmentsByQuestionId(questionId);
	    model.addAttribute("questionDetails", questionDetails);
}
	
	@GetMapping("/inquiry/questionCreate.do")
	public void qreateCuestion(Question question, Model model) {

		Question questions = questionService.findQuestionById(question);
	    model.addAttribute("questions", questions);
	}
	
	/**
	 *  관리자 1:1 문의 제목, 내용 검색
	 * @author 전예라
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
	 * @author 김대원
	 *  전체회원 이름,아이디 검색
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
	 * @author 김대원
	 *  구독회원 이름,아이디 검색
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
	 * @author 김대원
	 * 주문목록 조회
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
	 * @author 김대원
	 * 다중조건 검색 주문 조회
	 */
	@GetMapping("/adminOrderSearch.do")
	public String adminOrderSearch(
			@RequestParam(required = false) String searchKeyword,
	        @RequestParam(required = false) String startDate,
	        @RequestParam(required = false) String endDate,
	        @RequestParam(required = false) List<String> paymentMethod,
	        @RequestParam(required = false) List<String> orderStatus,
			Model model) {
		// paymentMethod 전체선택 or 선택X 이면 전체paymentMethod 검색
		if (paymentMethod == null || paymentMethod.size() == 3) {
		    paymentMethod = Arrays.asList("0", "1");
		}
		if(orderStatus == null || orderStatus.size() == 8) {
			orderStatus = Arrays.asList("0", "1", "2", "3", "4", "5", "6");
		}		
		List<OrderAdminListDto> orderlists =
				orderService.adminOrderSearch(searchKeyword, startDate, endDate, paymentMethod, orderStatus);
		
		model.addAttribute("orderlists", orderlists);
		return "admin/adminOrderList";
	}
	
	

	
	/**
	 * @author 김대원
	 * 상품별 판매량 통계 조회
	 */
	@GetMapping("/adminStatisticsProduct.do")
	public void adminStatisticsProduct(Model model) {
		List<OrderAdminProductStatisticsDto> productStatistics = orderService.adminStatisticsProduct();
		model.addAttribute("productStatistics", productStatistics);
		List<OrderAdminProductStatisticsDto> priceStatistics = orderService.adminStatisticsPrice();
		model.addAttribute("priceStatistics", priceStatistics);
	}
	
	
	/**
	 * @author 김대원
	 * 날짜별 판매량 통계 조회
	 */
	@GetMapping("/adminStatisticsByDate.do")
	public void adminStatisticsByDate(Model model) {
		List<OrderAdminStatisticsByDateDto> dailyStatistics = orderService.adminStatisticsByDaily();
		List<OrderAdminStatisticsByDateDto> monthlyStatistics = orderService.adminStatisticsByMonthly();
		model.addAttribute("dailyStatistics", dailyStatistics);
		model.addAttribute("monthlyStatistics", monthlyStatistics);
	}
	
	

	/**
	 * @author 김담희
	 * 상품정보 조회 
	 */
	@GetMapping("/adminProductList.do")
	public void adminProductList(
		@AuthenticationPrincipal MemberDetails member,Model model) {
		List<AdminProductDto> productInfos = productService.findProductsAll();
		model.addAttribute("productInfos", productInfos);
	}
	

	/**
	 * @author 김담희
	 * 상품정보 검색
	 */
	@GetMapping("adminProductSearch.do")
	public String adminProductSearch(
			@RequestParam("searchKeyword") String searchKeyword,
			@AuthenticationPrincipal MemberDetails member,
			Model model) {
		
		List<AdminProductDto> productInfos = productService.findAdminProductsBySearch(searchKeyword);
		model.addAttribute("productInfos", productInfos);
		return "admin/adminProductList";
	}
	
	/**
	 * @author 전수경
	 * - 상품등록 폼으로 이동
	 */
	@GetMapping("/adminProductCreate.do")
	public void adminProductCreate(
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
	@PostMapping("/adminProductCreate.do")
	public String adminProductCreate(
			@Valid ProductCreateDto _product,
			@AuthenticationPrincipal MemberDetails member, 
			Model model) throws IllegalStateException, IOException {
		
		log.debug("ProductCreateDto = ", _product);
		
		List<MultipartFile> thumbnailFiles = _product.getThumbnailFile();
		List<MultipartFile> detailFiles = _product.getDetailFile();


		String saveDirectory = application.getRealPath("/resources/upload/product");
		
		List<ImageAttachment> attachments = new ArrayList<>();
		// 1. 썸네일 파일 처리
		for(MultipartFile upFile : thumbnailFiles) {
			if(!upFile.isEmpty()) {
				String imageOriginalFilename = upFile.getOriginalFilename();
				String imageRenamedFilename = HelloSpringUtils.getRenameFilename(imageOriginalFilename);
				File destFile = new File(saveDirectory, imageRenamedFilename);
				
				upFile.transferTo(destFile);

				int imageType = 1;

				ImageAttachment attach =
						ImageAttachment.builder()
						.imageOriginalFilename(imageOriginalFilename)
						.imageRenamedFilename(imageRenamedFilename)
						.imageType(imageType)
						.imageFileSize(upFile.getSize())
						.thumbnail(Thumbnail.Y)
						.build();
				attachments.add(attach);
			}
		}
		
		// 2. 상세이미지 파일 처리
		for(MultipartFile upFile : detailFiles) {
			if(!upFile.isEmpty()) {
				String imageOriginalFilename = upFile.getOriginalFilename();
				String imageRenamedFilename = HelloSpringUtils.getRenameFilename(imageOriginalFilename);
				File destFile = new File(saveDirectory, imageRenamedFilename);
				
				upFile.transferTo(destFile);
				
				int imageType = 1;
				
				ImageAttachment attach =
						ImageAttachment.builder()
						.imageOriginalFilename(imageOriginalFilename)
						.imageRenamedFilename(imageRenamedFilename)
						.imageType(imageType)
						.imageFileSize(upFile.getSize())
						.thumbnail(Thumbnail.N)
						.build();
				attachments.add(attach);
			}
		}
		

		// 3. db저장
		ProductImages productImages = ProductImages.builder()
				.categoryId(_product.getCategoryId())
				.productName(_product.getProductName())
				.productPrice(_product.getProductPrice())
				.attachments(attachments)
				.build(); // 상품카테고리아이디, 상품명, 가격
		int productId = productService.insertProduct(productImages); // 여기서 이미지도 저장
		
		// 2.1. productDetail 객체 저장
		List<ProductDetail> productDetails = _product.getProductDetail();
		for(ProductDetail productDetail : productDetails) {
			if(productDetail.getOptionName() == null || productDetail.getOptionName() == "") {
				
			} else {
				productDetail.setProductId(productId);
				int result = productService.insertProductDetail(productDetail);
				int productDetailId = productDetail.getProductDetailId();
				
			}
			
		}
		
		return "redirect:/admin/adminProductList.do";
	}
	
	/**
	 * @author 전수경
	 * 상품수정 폼으로 연결
	 */
	@GetMapping("/adminProductUpdate.do")
	public void adminProductUpdate(
			@RequestParam int productId,
			@AuthenticationPrincipal MemberDetails member, 
			Model model
			) {
		
		// 상품카테고리 가져오기
		List<ProductCategory> categories = productService.findAll();
		// 상품정보 가져오기
		Product product = productService.findProductById(productId);
		// 상품이미지 가져오기
		ProductImages productImages = productService.findImageAttachmentsByProductId(product.getProductId());
		List<ImageAttachment> attachments = productImages.getAttachments();
		// 상품옵션 가져오기(리스트)
		List<ProductDetail> productDetails = productService.findAllProductDetailsByProductId(productId);
		
		model.addAttribute("categories", categories);
		model.addAttribute("product", product);
		model.addAttribute("attachments", attachments);
		model.addAttribute("productDetails", productDetails);
	}
	
	/**
	 * @author 전수경
	 * 상품옵션 추가
	 */
	@PostMapping("/adminOptionCreate.do")
	public ResponseEntity<?> adminOptionCreate(
			@Valid @RequestBody ProductOptionCreateDto _product,
			@AuthenticationPrincipal MemberDetails member 
			) {
		int productId = _product.getProductId();
		ProductDetail productDetail = _product.toProductDetail();
    	
        // 상품 옵션 업데이트 로직 수행
        int result = productService.adminOptionCreate(productDetail);

        return ResponseEntity.ok(result);
	}
	
	
	
	/**
	 * @author 전수경
	 * 상품 수정
	 */
	@PostMapping("/adminProductUpdate.do")
	public ResponseEntity<?> adminProductUpdate(
			@Valid @RequestBody ProductUpdateDto _product,
			@AuthenticationPrincipal MemberDetails member 
			) {
		
		Product product = _product.toProduct();
		// 상품정보 수정하기
		int result = productService.updateProduct(product);
		
		return ResponseEntity.ok(result);
	}
	
	/**
	 * @author 전수경
	 * 상품옵션 수정
	 */
	@PostMapping("/adminProductDetailUpdate.do")
	public ResponseEntity<?> adminProductDetailUpdate(
			@Valid @RequestBody ProductDetailUpdateDto _product,
			@AuthenticationPrincipal MemberDetails member 
			) {
		ProductDetail productDetail = _product.toProductDetail();
		
		// 상품 옵션 업데이트 로직 수행
		int result = productService.updateProductDetail(productDetail);
		
		return ResponseEntity.ok(result);
	}
	
	
	/**
	 * @author 전수경
	 * 상품 삭제
	 */
	@PostMapping("/adminProductDelete.do")
	public ResponseEntity<?> adminDeleteProduct(
			@Valid @RequestBody ProductDeleteDto _product,
			@AuthenticationPrincipal MemberDetails member
			){
		
		int result = productService.deleteProduct(_product.getProductId());
		
		return ResponseEntity.ok(result);
	}


	/**
	 * @author 전수경
	 * 상품옵션 삭제
	 */
	@PostMapping("/adminProductOptionDelete.do")
	@ResponseBody
	public ResponseEntity<?> adminProductOptionDelete(
			@Valid @RequestBody ProductOptionDeleteDto _product,
			@AuthenticationPrincipal MemberDetails member
	) {
		int result = productService.deleteProductDetail(_product.getProductDetailId());
		
	    return ResponseEntity.ok(result);
	}

}



