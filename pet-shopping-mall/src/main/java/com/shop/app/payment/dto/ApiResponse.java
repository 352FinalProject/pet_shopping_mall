package com.shop.app.payment.dto;

import java.util.List;

import com.shop.app.member.entity.SubMember;

import lombok.Data;

@Data
public class ApiResponse {
    private int code;
    private String message;
    private List<SubMember> response;
}