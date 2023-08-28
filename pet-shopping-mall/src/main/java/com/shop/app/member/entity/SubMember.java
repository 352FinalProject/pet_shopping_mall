package com.shop.app.member.entity;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SubMember {
    private int subscribeId;
    private String memberId;
    private String merchantUid;
    private Timestamp scheduleAt;
    private String scheduleStatus;
    private int amount;
}
