<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />
<style>
.order-no a {
	font-weight: 600;
	color: #5886d3;
}
</style>
<section class="common-section" id="common-section-List">
	<div class="common-title">취소내역</div>
	<div class="common-container-side">
		<div class="order-top">
			<select name="selectPeriod" id="selectPeriod">
				<option>전체</option>
				<option value="3">최근 3개월</option>
				<option value="6">최근 6개월</option>
				<option value="12">최근 12개월</option>
			</select>
		</div>
		<div class="service-util-div-sidebar-cancel">
			<table class="service-product-utility-sidebar">
				<thead>
					<tr>
						<th>날짜</th>
						<th>주문번호</th>
						<th>주문금액</th>
						<th>처리상태</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty cancelInfoList}">
						<c:forEach items="${cancelInfoList}" var="order" varStatus="vs">
							<c:set var="index" value="${order.orderStatus}" />
							<c:set var="amount" value="${order.amount}" />
							<fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"
								var="formattedDate" />
							<tr>
								<td>
									<p>${formattedDate}</p>
								</td>
								<td><span class="order-no"><a
										href="${pageContext.request.contextPath}/order/cancelOrderDetail.do?orderNo=${order.orderNo}">${order.orderNo}</a></span>
								</td>
								<td><span id="total-price"><fmt:formatNumber
											value="${order.amount}" groupingUsed="true" />원</span></td>
								<td>
									<p>${status[index]}</p>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
			<c:if test="${empty cancelInfoList}">
				<div class="empty-message">조회된 취소 내역이 없습니다.</div>
			</c:if>
		</div>
	</div>
	<nav aria-label="...">
		<ul class="pagination pagination-sm">
			<c:forEach begin="1" end="${totalPages}" var="pageNumber">
				<li class="page-item ${page == pageNumber ? 'active' : ''}"><a
					class="page-link"
					href="${pageContext.request.contextPath}/member/cancelOrderList.do?page=${pageNumber}">
						<span class="page-number">${pageNumber}</span>
				</a></li>
			</c:forEach>
		</ul>
	</nav>
</section>
<script>
const periodSelect = document.querySelector("#selectPeriod");
const table = document.querySelector("#order-table tbody")
	
const handleSelectChange = () => {
    const period = periodSelect.value;
    window.location.href="${pageContext.request.contextPath}/order/cancelOrderList.do?period=" + period;
};

periodSelect.addEventListener('change', handleSelectChange);
</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />