package com.shop.app.coupon.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.app.coupon.dto.MemberCouponDto;
import com.shop.app.coupon.entity.MemberCoupon;
import com.shop.app.coupon.service.CouponService;
import com.shop.app.member.entity.MemberDetails;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/coupon")
public class CouponController {

	@Autowired
	private CouponService couponService;

   /**
    * @author 전예라
    * 쿠폰 전체 내역 조회
    */
	@GetMapping("/couponList.do")
	public void couponList(Model model, @AuthenticationPrincipal MemberDetails member, MemberCouponDto memberCoupon) {

		String memberId = member.getMemberId();
		List<MemberCouponDto> memberCoupons = couponService.findCouponAll(memberId);
		model.addAttribute("memberCoupons", memberCoupons);
	}

}
