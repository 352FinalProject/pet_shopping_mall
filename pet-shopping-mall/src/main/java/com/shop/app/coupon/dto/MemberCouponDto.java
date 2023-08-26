package com.shop.app.coupon.dto;

import java.time.LocalDateTime;

import com.shop.app.coupon.entity.Coupon;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberCouponDto {
    private int memberCouponId;
    private int couponId;
    private String memberId;
    private LocalDateTime createDate;
    private LocalDateTime endDate;
    private int useStatus;
    private LocalDateTime useDate;
    private String couponName;
    
    private Coupon coupon;
}
