<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="sidebar2">
	<ul class="sidebar2-text">
		<li class="sidebar2-title">마이페이지</li>
		<li class="sidebar2-mysp">
			<h2 class="sidebar2-title2">마이 쇼핑</h2></a>
			<ul>
				<li><a href="#">주문내역</a></li>
				<li><a href="#">취소/반품</a></li>
				<li><a href="#">찜한상품</a></li>
				<li><a href="#">내가 쓴 문의</a></li>
			</ul>
		</li>
		<li class="sidebar2-mybe">
			<h2 class="sidebar2-title2">마이 혜택</h2></a>
			<ul>
				<li><a href="${pageContext.request.contextPath}/point/pointList.do">포인트 내역</a></li>
				<li><a href="#">내가 쓴 리뷰</a></li>
			</ul>
		</li>
		<li class="sidebar2-pro">
			<h2 class="sidebar2-title2">마이 정보</h2></a>
			<ul>
				<li><a href="${pageContext.request.contextPath}/member/myPage.do">회원정보 수정</a></li>
				<li><a href="${pageContext.request.contextPath}/member/petList.do">펫 목록</a></li>
				<li><a href="${pageContext.request.contextPath}/member/petProfile.do">펫 등록</a></li>
				<li><a href="#">펫정보 수정</a></li>
			</ul>
		</li>
	</ul>
</div>
<script>
</script>
