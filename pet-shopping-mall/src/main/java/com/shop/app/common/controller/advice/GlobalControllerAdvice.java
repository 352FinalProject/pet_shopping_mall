package com.shop.app.common.controller.advice;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.validation.ConstraintViolationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.member.entity.MemberDetails;
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

@ControllerAdvice
@Slf4j
public class GlobalControllerAdvice {

	//	@ExceptionHandler(Exception.class)
	//	public String exceptionHandler(Exception e) {
	//		log.error(e.getMessage(), e);
	//		return "common/error";
	//	}
	//	
	//	@ExceptionHandler(ConstraintViolationException.class)
	//	public String invalidRequestValue(ConstraintViolationException e) {
	//		log.error("입력값오류!! " + e.getMessage(), e);
	//		return "common/error";
	//	}

	// 김대원 알림
	@Autowired
	private NotificationService notificationService;

	@ModelAttribute("notifications")
	public List<Notification> addNotificationsToModel(@AuthenticationPrincipal MemberDetails member) {
		if (member != null) {
			List<Notification> notifications = notificationService.findAllNotification(member.getMemberId());
			return notifications;
		}
		return Collections.emptyList();
	}
}
