package com.shop.app.common.controller.advice;

import java.util.Collections;
import java.util.List;

import javax.validation.ConstraintViolationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.member.entity.MemberDetails;
import com.shop.app.notification.entity.Notification;
import com.shop.app.notification.service.NotificationService;

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
	
}
