package com.shop.app.notification.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.shop.app.notification.entity.Notification;

@Mapper
public interface NotificationRepository {
	
	@Insert("insert into notification(id, noti_category, noti_content, noti_created_at, member_id) values (seq_notification_id.nextval, #{notiCategory}, #{notiContent}, #{notiCreatedAt}, #{memberId})")
	int insertNotification(Notification insertNotification);
	
	@Select("select * from notification where member_id= #{memberId, jdbcType=VARCHAR} order by noti_created_at asc")
	List<Notification> findAllNotification(String memberId);
	
	@Delete("delete notification where id = #{id}")
	int deleteNotification(int id);

	@Select("select * from notification where id = (select max(id) from notification)")
	Notification latestNotification();


	
	
}
