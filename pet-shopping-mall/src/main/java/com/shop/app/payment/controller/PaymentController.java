package com.shop.app.payment.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.shop.app.cart.dto.CartListDto;
import com.shop.app.order.dto.OrderCreateDto;
import com.shop.app.order.entity.Order;
import com.shop.app.order.service.OrderService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/payment")
@Controller
public class PaymentController {

	@Autowired
	OrderService orderService;
	
	private IamportClient iamportClient;
	private IamportApi IamportApi;
	
	
	public PaymentController(IamportApi api) {
		this.IamportApi = api;
		String IMP_API = api.getApiKey();
		log.debug("IMP_API = {}" , IMP_API);
		String IMP_SECRET = api.getApiSecret();
		this.iamportClient = new IamportClient(IMP_API, IMP_SECRET);
	}
	
	
	@GetMapping("/paymentInfo.do")
	public void payment() {
		// 폼으로 가져오기
		
	}
	
	/**
	 * 결제 API 실행 전 주문 테이블에 먼저 주문 정보 insert 하기 위한 메소드
	 */
	@ResponseBody
	@PostMapping("/proceed.do")
	public Map<String, Object> paymentProceed(@Valid @RequestBody OrderCreateDto _order) {
	    Map <String, Object> resultMap = new HashMap<>();
	    log.debug("_order = {}", _order);
	    Order order = _order.toOder();
	    int result = orderService.insertOrder(order);
	    log.debug("result = {}", result);
	    
	    String msg = "";
	    
	    if(result > 0) 
	    	msg = "주문에 성공하셨습니다.";
	    else 
	    	msg = "주문에 실패하셨습니다. 관리자에게 문의하세요.";	
	    	
	    resultMap.put("result", result);
	    resultMap.put("msg", msg);
	    
	    return resultMap;
	}
	
	
	@PostMapping("/verifyIamport/{imp_uid}")
	@ResponseBody
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session
									, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException{
		log.debug("imp_uid= {}", imp_uid);
		return iamportClient.paymentByImpUid(imp_uid);
	}
	
}