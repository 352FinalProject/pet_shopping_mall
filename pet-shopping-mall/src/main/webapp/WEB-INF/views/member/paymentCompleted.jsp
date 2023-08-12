<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
.payment-common-container { /* 전체 */
	align-items: center;
	text-align: center;
	align-content: stretch;
	justify-content: center;
}

.payment-main-button {
	display: flex; /* 버튼을 같은 행에 배치 */
	justify-content: center; /* 가운데 정렬 */
	gap: 30px;
}

.table-bordered-payment {
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
	align-content: stretch;
	justify-content: center;
	font-size: 17px;
	border: 0.5px solid #000; /* 0.5픽셀 두께의 검은색 테두리 */
	border-radius: 20px;
	padding: 100px; /* 테두리와 텍스트 사이의 간격 */
	background: white
}

.payment-main-button button {
	background-color: #5886d3; /* 버튼의 배경색 */
	color: white; /* 버튼의 글자색 */
	border: none; /* 테두리 제거 */
	padding: 10px; /* 패딩으로 크기 조정 */
	text-align: center; /* 텍스트 중앙 정렬 */
	text-decoration: none; /* 텍스트 장식 제거 */
	font-size: 20px; /* 글자 크기 설정 */
	cursor: pointer; /* 마우스 오버시 커서 변경 */
	margin-right: 10px; /* 버튼 사이의 간격을 10픽셀로 설정 */
	margin-top: 100px;
	margin-bottom: 100px;
	border-radius: 20px;
}

.payment-main-button #payment-btn1 {
	background-color: #c8c8c8;
}

.check-image img {
	margin-top: 130px;
	width: 5%; /* 이미지 너비를 50%로 설정 */
	height: 5%; /* 높이는 자동으로 조정 */
}

.check-image h1 {
	font-size: 30px;
	margin: 20px;
	margin-bottom: 30px;
}

.table-bordered-payment th, .table-bordered-payment td {
	padding: 20px; /* th와 td 사이의 간격을 20px로 설정 */
}
</style>


<section class="common-section-payment" id="payment-complete-section">
	<div class="payment-common-container">
		<div class="check-image">
			<img
				src="${pageContext.request.contextPath}/resources/images/회원가입/check.png" />
			<h1>결제가 완료되었습니다.</h1>

		</div>
		<div class="table-bordered-payment">
			<table>
				<tr>
					<th>주문 상품</th>
					<td><span class="order-number">${order.productName}리드줄</span></td>
				</tr>
				<tr>
					<th>결제 금액</th>
					<td><span class="order-number">${order.totalAmount}7,990원</span></td>
				</tr>
				<tr>
					<th>주문 번호</th>
					<td><span class="order-number">${order.orderNumber}232-322-22231</span></td>
				</tr>
			</table>
		</div>
		<div class="payment-main-button">
			<form action="<%=request.getContextPath()%>/main" method="get">
				<button id="payment-btn1" type="submit">메인으로 가기</button>
			</form>
			<form action="<%=request.getContextPath()%>/main" method="get">
				<!-- 주문 조회 URL을 수정하실 수 있습니다 -->
				<button type="submit">주문 조회</button>
			</form>
		</div>

	</div>
</section>

<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
