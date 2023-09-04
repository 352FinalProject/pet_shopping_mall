package com.shop.app.wishlist.repositoty;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.session.RowBounds;

@Mapper
public interface WishlistRepository {
	// 찜 여부 체크 (선모)
	@Select("SELECT COUNT(*) FROM wishlist WHERE WISHLIST_PRODUCT_ID = #{productId} AND WISHLIST_MEMBER_ID = #{memberId}")
	int getLikeProduct(int productId, String memberId);
	
	// 찜 등록 (선모)
	@Insert("INSERT INTO wishlist VALUES (seq_wishlist_id.nextval, #{memberId}, #{productId}, SYSDATE)")
	@SelectKey(
			before = false,
			keyProperty = "wishlistId",
			resultType = int.class,
			statement = "select seq_wishlist_id.currval from dual"
			)
	int insertPick(int productId, String memberId);
	
	// 찜 제거 (선모)
	@Insert("DELETE FROM wishlist WHERE WISHLIST_MEMBER_ID = #{memberId} AND WISHLIST_PRODUCT_ID = #{productId}")
	int deletePick(int productId, String memberId);
	
	// 내 찜 목록 가져오기 (선모)
	@Select("SELECT COUNT(*)"
			+ "  FROM wishlist wl"
			+ "  LEFT OUTER JOIN ("
			+ "       SELECT pd.*, imgTbl.image_renamed_filename"
			+ "         FROM product pd"
			+ "         LEFT OUTER JOIN ("
			+ "              SELECT iam.ref_id, ia.image_renamed_filename"
			+ "                FROM image_attachment_mapping iam"
			+ "               INNER JOIN image_attachment ia"
			+ "                  ON iam.image_id = ia.image_id"
			+ "	 			    AND ia.thumbnail = 'Y') imgTbl"
			+ "           ON pd.product_id = imgTbl.ref_id) pdInfo"
			+ "    on wl.wishlist_product_id = pdInfo.product_id"
			+ " WHERE wl.wishlist_member_id = #{memberId}")
	int getListCount(Map<String, Object> paramMap);
	
	// 내 찜 목록 가져오기 (선모)
	@Select("SELECT *"
			+ "  FROM wishlist wl"
			+ "  LEFT OUTER JOIN ("
			+ "       SELECT pd.*, imgTbl.image_renamed_filename"
			+ "         FROM product pd"
			+ "         LEFT OUTER JOIN ("
			+ "              SELECT iam.ref_id, ia.image_renamed_filename"
			+ "                FROM image_attachment_mapping iam"
			+ "               INNER JOIN image_attachment ia"
			+ "                  ON iam.image_id = ia.image_id"
			+ "	 			    AND ia.thumbnail = 'Y') imgTbl"
			+ "           ON pd.product_id = imgTbl.ref_id) pdInfo"
			+ "    on wl.wishlist_product_id = pdInfo.product_id"
			+ " WHERE wl.wishlist_member_id = #{memberId}")
	List<Map<String, Object>> getMyWishList(RowBounds rowBounds, Map<String, Object> paramMap);
}