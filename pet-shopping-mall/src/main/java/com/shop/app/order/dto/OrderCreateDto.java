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
	
	private int pointsUsed; // 사용하려는 포인트 (예라)
	private int couponId; // 사용하려는 쿠폰 (예라)
	private Boolean useCoupon; // 쿠폰 사용 여부 (예라)
	private int couponDiscount; // 쿠폰 할인 가격 (예라)
	
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
				.discount(pointsUsed + couponDiscount)  // 사용된 포인트, 쿠폰을 할인 금액으로 설정 (예라)
				.discountDetail(discountDetailValue)
				.amount(amount)        // 할인된 금액을 반영하여 결제 금액 설정 (예라)
				.memberCouponId(memberCouponId)
				.build();
	}

}
