package com.shop.app.notification.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.notification.entity.Notification;

@Mapper
public interface NotificationRepository {
	
	@Insert("insert into notification(id, noti_category, noti_content, noti_created_at, member_id) values (seq_notification_id.nextval, #{notiCategory}, #{notiContent}, CURRENT_TIMESTAMP, #{memberId})")
	int insertNotification(Notification message);
	
	@Select("select * from notification where member_id= #{memberId}")
	List<Notification> findAllNotification(String memberId);
	
	
	
}
