package com.shop.app.notification.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.shop.app.notification.entity.Notification;
import com.shop.app.order.dto.OrderCompleteNotificationDto;

@Mapper
public interface NotificationRepository {
	@Insert("insert into (id, noti_category, noti_content, noti_created_at, member_id) values (seq_notification_id.nextval, #{notiCategory}, #{notiContent}, default, #{memberId})")
	int notifyOrderComplete(Notification notification);

}
