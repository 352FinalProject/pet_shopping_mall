<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<table class="table table-striped table-hover">
	<thead class="table-dark">
		<tr>
			<th>번호</th>
			<th>주문일시</th>
			<th>주문번호</th>
			<th>이미지</th>
			<th>주문상품</th>
			<th>수량</th>
			<th>상품금액</th>
			<th>배송비</th>
			<th>주문상태</th>
			<th>주문자</th>
			<th>총주문액</th>
			<th>결제방법</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach begin="0" end="20" step="1" varStatus="status">
			<tr>
				<th>${status.count}</th>
				<th>주문일시</th>
				<th><a href="#" />주문번호</th>
				<th><a href="#" />이미지</th>
				<th><a href="#" />주문상품</th>
				<th>수량</th>
				<th>상품금액</th>
				<th>배송비</th>
				<th>주문상태</th>
				<th>주문자</th>
				<th>총주문액</th>
				<th>결제방법</th>
			</tr>
		</c:forEach>
			
	</tbody>
</table>




















<jsp:include page="/WEB-INF/views/common/footer.jsp" />