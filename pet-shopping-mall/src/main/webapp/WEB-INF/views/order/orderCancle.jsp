<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
section.order-header {
	display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 0;
    border-bottom: 1px solid #e7e7e7;
}
section.order-header .order-title {
    text-align: center;
    font-size: 30px;
    padding-top: 40px;
    padding-bottom: 30px;
}
div.order-detail{
	display: flex;
	width: 65vw;
    height: 40vw;
}
div.order-detail div.order-info{
	display: flex;
	width : 100px;
	height: 40vw;;
}

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
		<div class="order-detail-wrapper">
			<div class="order-detail">
				<!-- 주문자 -->
				<div class="order-info client">
					<div class="title">주문자</div>
					<div class="info-details"></div>
					<div class="info-details"></div>
					
				</div>
				<!-- 배송지 -->
				<div class="order-info delivery-location">
					<div class="title">배송지</div>
					<div class="info-details"></div>
					<div class="info-details"></div>
				
				</div>
				<!-- 배송현황 -->
				<div class="order-info delivery-status">
					<div class="title">배송현황</div>
					<div class="info-details"></div>
					<div class="info-details"></div>
					
				</div>
				<!-- 결제금액 -->
				<div class="order-info total-price">
					<div class="title">결제금액</div>
					
				</div>
				<!-- 주문결제정보 -->
				<div class="order-info details">
					<div class="title">주문결제정보</div>
					
				</div>
			</div>
		</div>
	</section>

	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>