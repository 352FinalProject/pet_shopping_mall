<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />
<style>
#order-table {
	width: 100%;
}
#info-message {
	font-size: 20px;
}
</style>
<section class="common-section" id="#">
	<div class="common-title">주문 상세 내역</div>
	<div class="common-container">
		<div class="common-div">
				<div class="order">
					<table id="order-table">
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
						<c:if test="${not empty orderDetail}">
							<sec:authentication property="principal" var="loginMember" />
							<c:forEach var="orderMap" items="${orderDetail}">
								<c:forEach var="entry" items="${orderMap}">
								<c:set var="index" value="${entry.key.orderStatus}"/>
								<c:set var="option" value="${entry.key.optionName}" />
								<c:set var="amount" value="${entry.key.amount}" />
								<fmt:formatDate value="${entry.key.orderDate}" pattern="yyyy-MM-dd" var="formattedDate"/>
								<tr>
									<td>${formattedDate}</td>
									<td>
										<p>${entry.key.orderNo}</p>
									</td>
									<td>
										<div class="flex">
											<img src="${pageContext.request.contextPath}/resources/upload/product/${entry.key.imageRenamedFileName}" width="110px">
											<div>
												<p>${entry.key.productName}</p>
												<br />
											<c:if test="${option eq null}">
												<p>선택된 옵션이 없습니다.</p>
											</c:if>
											<c:if test="${option ne null}">
												<p>${entry.key.optionName} : ${entry.key.optionValue}</p>
											</c:if>
												<p>수량: ${entry.key.quantity}개</p>
											</div>
										</div>
									</td>
									<td><span id="total-price"><fmt:formatNumber
												value="${entry.key.amount}" groupingUsed="true" />원</span></td>
									<td>
										<p>${status[index]}</p>
									</td>
								</tr>
								<c:if test="${payment eq null}">
								<tr class="detail-row">
							        <td colspan="5">
							            <div class="detail-content">
							                <p>추가 정보 1</p>
							                <p>추가 정보 2</p>
							            </div>
							        </td>
							    </tr>
							    </c:if>
								</c:forEach>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
			<c:if test="${empty orderDetail}">
				<div class="empty-message">조회된 주문 내역이 없습니다.</div>
			</c:if>
			</div>
		</div>
	</div>
</section>
<script>

</script>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />