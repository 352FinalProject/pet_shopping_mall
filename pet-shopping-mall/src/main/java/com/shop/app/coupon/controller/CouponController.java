package com.shop.app.coupon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.app.coupon.entity.MemberCoupon;
import com.shop.app.coupon.service.CouponService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/coupon")
public class CouponController {

	@Autowired
	private CouponService couponService;
	
	@GetMapping("/couponList.do")
	public void couponList(@RequestParam int couponId, MemberCoupon memberCoupon, Model model) {
		
		memberCoupon.setCouponId(couponId);
		
		List<MemberCoupon> memberCoupons = couponService.findMemberCouponAll(memberCoupon);
		model.addAttribute("memberCoupons", memberCoupons);
		
		log.debug("memberCoupons = {}", memberCoupons);
	}
	
}
