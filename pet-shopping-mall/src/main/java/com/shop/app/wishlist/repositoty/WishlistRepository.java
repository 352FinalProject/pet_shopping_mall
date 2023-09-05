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
	/**
	 * @author 강선모
	 * 찜 여부 체크   
	 */
	@Select("SELECT COUNT(*) FROM wishlist WHERE WISHLIST_PRODUCT_ID = #{productId} AND WISHLIST_MEMBER_ID = #{memberId}")
	int getLikeProduct(int productId, String memberId);
	/**
	 * @author 강선모
	 * 찜 등록  
	 */
	@Insert("INSERT INTO wishlist VALUES (seq_wishlist_id.nextval, #{memberId}, #{productId}, SYSDATE)")
	@SelectKey(
			before = false,
			keyProperty = "wishlistId",
			resultType = int.class,
			statement = "select seq_wishlist_id.currval from dual"
			)
	int insertPick(int productId, String memberId);
	/**
	 * @author 강선모
	 * 찜 제거  
	 */
	@Insert("DELETE FROM wishlist WHERE WISHLIST_MEMBER_ID = #{memberId} AND WISHLIST_PRODUCT_ID = #{productId}")
	int deletePick(int productId, String memberId);
	/**
	 * @author 강선모
	 * -찜 되어 있는 요소의 갯수  
	 * -int 타입의 값을 반환, 이 값은 찜 목록에 저장된 아이템의 총 개수를 나타냅니다.
	 */
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
	
	/**
	 * @author 강선모
	 * -찜 되어 있는 요소 가져오기
	 * -List<Map<String, Object>> 타입의 리스트를 반환합니다.
	 *  각 항목은 찜 목록에 저장된 아이템의 상세 정보를 나타내는 맵(Map)입니다.
	 *  이 메서드는 페이징을 지원하며, RowBounds를 사용하여 특정 페이지의 아이템을 가져올 수 있습니다.
	 */
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