package com.shop.app.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.member.entity.MemberDetails;
import com.shop.app.order.dto.OrderCancelInfoDto;
import com.shop.app.order.dto.OrderHistoryDto;
import com.shop.app.order.entity.Order;
import com.shop.app.order.service.OrderService;
import com.shop.app.payment.entity.Payment;
import com.shop.app.point.entity.Point;
import com.shop.app.point.service.PointService;
import com.shop.app.product.service.ProductService;
import com.shop.app.review.entity.Review;

import lombok.extern.slf4j.Slf4j;

@Validated
@RequestMapping("/order")
@Controller
@Slf4j
public class OrderController {
	
	public static String[] status = {"결제완료", "배송준비", "배송중", "배송완료", "주문취소", "환불완료", "구매확정"};
 
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	PointService pointService;
	
	
	@GetMapping("/orderExchange.do")
	public void orderExchange() {}
	
	/**
	 * 멤버 개인이 주문 내역 조회
	 */
	@GetMapping("/orderList.do")
	public void getOrderList(Model model, @RequestParam(name = "period", required = false) Integer period, @AuthenticationPrincipal MemberDetails member) {
	    String memberId = member.getMemberId();
	    List<Order> orderList;

	    if (period != null) 
	    	orderList = orderService.getOrderListByPeriod(memberId, period);
	    else 
	    	orderList = orderService.getOrderList(memberId);
			
	    model.addAttribute("status", status);
	    model.addAttribute("orderHistories", orderList);
	}
	
	@GetMapping("/cancelOrderDetail.do")
	public void cancelOrder(Model model, @RequestParam String orderNo) {
		OrderCancelInfoDto cancelInfos = orderService.getCancelInfo(orderNo);
		model.addAttribute("cancelInfo", cancelInfos);
	}
	
	
	/**
	 * 미입금 주문의 주문 취소 (환불은 paymentController)
	 */
	@PostMapping("/cancelOrder.do")
	public String insertCancelOrder(RedirectAttributes redirectAttr, @RequestParam String orderNo, @RequestParam String isRefund) {
		int result = orderService.insertCancelOrder(orderNo, isRefund);
		
		return "redirect:/order/orderList.do";
	}
	
	
	@GetMapping("/cancelOrderList.do")
	public void getCancelOrderList(Model model, @RequestParam(name = "period", required = false) Integer period, @AuthenticationPrincipal MemberDetails member) {
		String memberId = member.getMemberId();
		List<OrderCancelInfoDto> cancelInfos;
		
		if (period != null) {
			cancelInfos = orderService.getCancelInfoByPeriod(memberId, period);
		} else {
			cancelInfos = orderService.getCancelInfoAll(memberId);
		}
	    model.addAttribute("status", status);
		model.addAttribute("cancelInfoList", cancelInfos);
	}
	
	// 결제창이 넘어가기 전에 취소하면 주문 테이블 자체에서 삭제
	@PostMapping("/deleteOrder.do")
	public String deleteOrder(@RequestParam String orderNo, RedirectAttributes redirectAttr) {
		int result = orderService.deleteOrder(orderNo);
		
		return "redirect:/cart/shoppingCart.do";
	}
	
	@GetMapping("/orderDetail.do")
	public void getOrderDetail(Model model, @RequestParam String orderNo, @AuthenticationPrincipal MemberDetails member) {
	    
	    List<Map<OrderHistoryDto, Payment>> orderDetailMap = orderService.getOrderDetail(orderNo);

	    if (!orderDetailMap.isEmpty()) {

	        String memberId = member.getMemberId();
	        
	        Map<String, Boolean> reviewWriteMap = new HashMap<>();
	        
	        for (Map<OrderHistoryDto, Payment> map : orderDetailMap) {
	            for (OrderHistoryDto orderHistory : map.keySet()) {
	                int productDetailId = orderHistory.getProductDetailId();
	                int productId = orderHistory.getProductId();
	                int orderId = orderHistory.getOrderId();
	                
	                boolean reviewWrite = orderService.reviewWrite(memberId, orderId, productDetailId, productId);
	               
	                String key = productDetailId + "-" + productId;
	                
	                reviewWriteMap.put(key, reviewWrite);
	            }
	        }
	        log.debug("reviewWriteMap = {}", reviewWriteMap);
	        model.addAttribute("reviewWrite", reviewWriteMap);
	    }
	    
	    model.addAttribute("status", status);
	    model.addAttribute("orderDetail", orderDetailMap);

	    log.debug(" 주문상태 status = {}", status);
	    log.debug("orderDetailMap= {}", orderDetailMap);
	}

	
	@GetMapping("/orderHistory.do")
	public void getOrderHistory() {}
}
