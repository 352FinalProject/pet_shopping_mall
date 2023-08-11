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
section.order-header select.sort-option {
    width: 100%;
    font-size: 15px;
    heiht: 40px;
    padding: 10px;
    margin-top: 30px;
}
section.order-header .my-reviews {
	margin-bottom: 25px;
	font-size: 18px;
    padding-top: 25px;
	float: right;
}

section.order-body {
}
table.order-history-tbl{
	display: flex;
	justify-content: center;
}
table.order-history-tbl thead{
}
table.order-history-tbl thead th{
	text-align: left;
    padding: 12px;
    border-top: 1px solid #e7e7e7;
    border-bottom: 1px solid #e7e7e7;
}
table.order-history-tbl tbody{
}
table.order-history-tbl img.product-img{
	display: flex;
    width: 10em;
    align-items: center;
}
table.order-history-tbl tbody td{

}
div.product-desc{
	display: flex;
    align-items: center
}
div.product-desc span{
	display: flex;
    align-items: center
}

</style>
<div class="common-section">
	<!-- 컨테이너 -->
	<div class="common-container">
	<!-- 주문 헤더 -->
	<section class="order-header">
		<div class="order-title">주문내역</div>
		
		<select name="sort-option" id="sort-option">
			<option value>1개월</option>
			<option value>3개월</option>
			<option value>6개월</option>
			<option value>12개월</option>
		</select>
		
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
		</tbody>
		</table>
		<div class="order-detail">
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
		</div>
		
	</section>

	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>