<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
.payment-common-container { /* 전체 */
	align-items: center;
    text-align: center;
    display: flex;
    justify-content: center;
    flex-direction: column;
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
	border: 0.5px solid #c8c8c8; /* 0.5픽셀 두께의 검은색 테두리 */
	border-radius: 20px;
	background: white;
	width: 600px;
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
	width: 25%; /* 이미지 너비를 50%로 설정 */
	height: 25%; /* 높이는 자동으로 조정 */
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
			<h1>${order.memberId}님 결제가 완료되었습니다.</h1>

		</div>
		<div class="table-bordered-payment">
			<table>
				<tr>
					<th>결제 금액</th>
					<td><fmt:formatNumber value='${order.amount}' pattern="0,000" var="formattedAmount" />
									<p id="point"><span></span>${formattedAmount}원</p></td>
				</tr>
				<tr>
					<th>주문 번호</th>
					<td><span class="order-number">${order.orderNo}</span></td>
				</tr>
			</table>
		</div>
		<div class="payment-main-button">
				<button id="payment-btn1" onclick="location.href='/pet'">메인으로 가기</button>
			<form:form action="${pageContext.request.contextPath}/order/orderDetail.do" method="get">
				<input type="hidden" name="orderNo" value="${order.orderNo}" />
				<button type="submit">주문 조회</button>
			</form:form>
		</div>

	</div>
</section>

<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
