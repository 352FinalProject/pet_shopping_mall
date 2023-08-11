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
		<div class="order-title">주문내역</div>
		
		<input type="range" name="sort-order" id="sort-order">
		<label for="sort-order">최근 1주일</label>
		<label for="sort-order">최근 한달</label>
		<label for="sort-order">최근 6개월</label>
		<label for="sort-order">최근 9개월</label>
		<label for="sort-order">최근 1년</label>
		
		<span class="my-reviews"><a href="${pageContext.request.contextPath}/member/reviews.do?memberId=">내가 쓴 상품 후기></a></span>
	</section>
	
	<!-- 주문 바디 -->
	<section class="order-body">
		
		<!-- 주문 내역 -->
		<table class="order-history-tbl">
		<thead>
			<tr>
				<th>날짜</th>
				<th>주문번호</th>
				<th>상품</th>
				<th>주문금액</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>2023.08.06</td>
				<td>
					<span>1234555555</span>
					<button class="exchange-refund">교환/환불신청</button>
				</td>
				<td>
					<img alt="상품이미지" 
						class="product-img"
						src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg">
					<div class="product-desc">
						<span class="product-name">리드줄 리드줄</span>
						<span class="product-options">옵션: 노란색</span>
						<span class="product-amount">수량: 1개</span>
					</div>
				</td>
				<td>7,990원</td>
				<td class="order-status">주문완료</td>
			</tr>
			<tr colspan="5" class="order-detail">
				<div class="order-detail-wrapper">
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
			</tr>
		</tbody>
		</table>
		
		
	</section>

	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>