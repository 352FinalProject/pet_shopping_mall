<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>

</style>
<div class="common-section">
	<!-- 컨테이너 -->
	<div class="common-container">
	<!-- 주문 헤더 -->
	<section class="order-header">
		<div class="order-title">주문취소</div>
		
		<span class="my-reviews"><a href="${pageContext.request.contextPath}/member/reviews.do?memberId=">내가 쓴 상품 후기></a></span>
	</section>
	
	<!-- 주문 바디 -->
	<section class="order-body">

	</section>

	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>