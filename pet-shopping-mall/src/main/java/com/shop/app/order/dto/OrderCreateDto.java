package com.shop.app.order.dto;


import java.util.List;

import javax.validation.Valid;

import com.shop.app.order.entity.Order;
import com.shop.app.order.entity.OrderDetail;

import lombok.Data;
import lombok.ToString;

@Valid
@Data
@ToString
public class OrderCreateDto {
	private String orderNo;
	private String memberId;
	private int totalPrice;
	private int deliveryFee;
	private int discount;
	private String discountDetail; // true면 포인트, false면 쿠폰
	private int amount;
	private String discountCode;
	private Integer memberCouponId;
		
	private List<OrderDetail> forms;
	
	private int pointsUsed;
	private int couponId;
	private Boolean useCoupon;
	private int couponDiscount;
	
	public Order toOder() {
	    
	    // 쿠폰, 포인트 2개 다 사용할 때
	    String discountDetailValue = "";
	    if(pointsUsed > 0 && couponId > 0) {
	        discountDetailValue = "쿠폰+포인트";
	    } else if (pointsUsed > 0) {
	        discountDetailValue = "포인트";
	    } else if (couponId > 0) {
	        discountDetailValue = "쿠폰";
	    }
	    
		return Order.builder()
				.orderNo(orderNo)
				.memberId(memberId)
				.totalPrice(totalPrice)
				.deliveryFee(deliveryFee)
				.discount(pointsUsed + couponDiscount)
				.discountDetail(discountDetailValue)
				.amount(amount)
				.memberCouponId(memberCouponId)
				.build();
	}

}
