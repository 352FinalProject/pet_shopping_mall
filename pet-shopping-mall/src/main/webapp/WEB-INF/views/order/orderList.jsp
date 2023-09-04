<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />
<style>
.detail-row {
	display: none;
	background-color: #f9f9f9;
}

.detail-row.show {
	display: table-row;
}

.detail-content {
	padding: 10px;
}
</style>
<section class="common-section" id="common-section-List">
	<div class="common-title">주문내역</div>
	<div class="common-container-side">
		<div class="order-top">
			<select name="selectPeriod" id="selectPeriod">
				<option>전체</option>
				<option value="3">최근 3개월</option>
				<option value="6">최근 6개월</option>
				<option value="12">최근 12개월</option>
			</select>
			<div class="order-review" style="margin-right : -90px;">
				<a style="margin-bottom: 10px;" href="${pageContext.request.contextPath}/review/reviewList.do">내가 쓴 상품 후기 ▶</a>
			</div>
		</div>
	</div>
	<div class="service-util-div-sidebar">
		<table class="service-product-utility-sidebar">
			<thead>
				<tr>
					<th>날짜</th>
					<th>주문번호</th>
					<th>주문금액</th>
					<th>주문취소</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty orderHistories}">
					<c:forEach items="${orderHistories}" var="order" varStatus="vs">
						<c:set var="index" value="${order.orderStatus}" />
						<c:set var="amount" value="${order.amount}" />
						<fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"
							var="formattedDate" />
						<tr>
							<td>${formattedDate}</td>
							<td><a
								href="${pageContext.request.contextPath}/order/orderDetail.do?orderNo=${order.orderNo}"><p>${order.orderNo}</p></a>
								<form:form id="cancelFrm" action="" method="POST">
									<input type="hidden" name="orderNo" value="${order.orderNo}" />
									<input type="hidden" name="amount" value="${order.amount}" />
									<input type="hidden" name="isRefund" value="" />
								</form:form></td>
							<td><span id="total-price"><fmt:formatNumber
										value="${order.amount}" groupingUsed="true" />원</span></td>
							<td>
								<c:if test="${index eq 0}">
									<a
										href="${pageContext.request.contextPath}/order/cancelOrderDetail.do?orderNo=${order.orderNo}"><button
										class="cancel-btn">취소신청</button></a>
								</c:if>
							</td>
							<td>
								<p>${status[index]}</p>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<c:if test="${empty orderHistories}">
			<div class="empty-message">조회된 주문 내역이 없습니다.</div>
		</c:if>
	</div>
<nav aria-label="...">
  	<ul class="pagination pagination-sm">
	    <c:forEach begin="1" end="${totalPages}" var="pageNumber">
	        <li class="page-item ${page == pageNumber ? 'active' : ''}">
	            <a class="page-link" href="${pageContext.request.contextPath}/order/orderList.do?page=${pageNumber}">
                    <span class="page-number">${pageNumber}</span>
                </a>
	        </li>
	    </c:forEach>
	</ul>
</nav>
</section>
<script>
const periodSelect = document.querySelector("#selectPeriod");
const table = document.querySelector("#order-table tbody");
	
const handleSelectChange = () => {
    const period = periodSelect.value;
    window.location.href="${pageContext.request.contextPath}/order/orderList.do?period=" + period;
};

periodSelect.addEventListener('change', handleSelectChange);

const cancelFrm = document.querySelector("#cancelFrm");
const amount = Number(cancelFrm.amount.value);
	
function cancelOrder(text){
		if(confirm("정말 주문을 취소하시겠습니까?") && text === 'cancel') {
			cancelFrm.isRefund.value = "N"
			cancelFrm.action = "${pageContext.request.contextPath}/order/cancelOrder.do";
			cancelFrm.submit();
			alert("주문이 정상적으로 취소되었습니다.");
		} else {
			cancelFrm.isRefund.value = "Y"
			cancelFrm.action = "${pageContext.request.contextPath}/import/refundOrder.do";
			cancelFrm.submit();
		}
};

</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />