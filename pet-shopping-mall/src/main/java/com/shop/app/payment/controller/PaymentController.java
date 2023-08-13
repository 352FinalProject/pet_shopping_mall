package com.shop.app.payment.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import com.shop.app.order.dto.OrderCreateDto;
import com.shop.app.order.entity.Order;
import com.shop.app.order.service.OrderService;
import com.siot.IamportRestClient.IamportClient;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/payment")
@Controller
public class PaymentController {

	@Autowired
	OrderService orderService;
	
	private IamportClient iamportClient;
	
	
	
	@GetMapping("/paymentInfo.do")
	public void payment() {}
	
	/**
	 * 결제 API 실행 전 주문 테이블에 먼저 주문 정보 insert 하기 위한 메소드
	 */
	@ResponseBody
	@PostMapping("/proceed.do")
	public Map<String, Object> paymentProceed(@Valid @RequestBody OrderCreateDto _order) {
	    Map <String, Object> resultMap = new HashMap<>();
	    Order order = _order.toOder();
	    int result = orderService.insertOrder(order);
	    String msg = "";
	    
	    if(result > 0) 
	    	msg = "주문에 성공하셨습니다.";
	    else 
	    	msg = "주문에 실패하셨습니다. 관리자에게 문의하세요.";	
	    	
	    resultMap.put("result", result);
	    resultMap.put("msg", msg);
	    
	    return resultMap;
	}
	
//	public IamportResponse<Payment> paymne
	
}
