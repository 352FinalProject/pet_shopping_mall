<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />
    <style>

	</style>
	<section class="common-section" id="#">
		<div class="common-title">주문내역</div>
		<div class="common-container">
			<div class="order">
				<div class="order-top">
					<select name="selectPeriod" id="selectPeriod">
						<option>전체</option>
						<option value="3">최근 3개월</option>
						<option value="6">최근 6개월</option>
						<option value="12">최근 12개월</option>
					</select> <a style="margin-bottom: 10px;" href="#">내가 쓴 상품 후기 ▶</a>
				</div>
				<table id="order-table">
					<thead>
						<tr>
							<th>날짜</th>
							<th>주문번호</th>
							<th>상품</th>
							<th>주문금액</th>
							<th>주문취소</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${not empty orderHistories}">
						<c:forEach items="${orderHistories}" var="order" varStatus="vs">
							<c:set var="index" value="${order.orderStatus}"/>
							<c:set var="option" value="${order.optionName}" />
							<c:set var="amount" value="${order.amount}" />
							<fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" var="formattedDate"/>
							<tr>
								<td>${formattedDate}</td>
								<td>
									<p>${order.orderNo}</p>
									<form:form id="cancelFrm" action="" method="POST">
										<input type="hidden" name="orderNo" value="${order.orderNo}" />
										<input type="hidden" name="amount" value="${order.amount}" />
										<input type="hidden" name="isRefund" value="" />
									</form:form>
								</td>
								<td><a
									href="${pageContext.request.contextPath}/member/orderDetail.do">
										<div class="flex">
											<img
												src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg"
												alt="">
											<div>
												<p>${order.productName}</p>
												<br />
											<c:if test="${option eq null}">
												<p>선택된 옵션이 없습니다.</p>
											</c:if>
											<c:if test="${option ne null}">
												<p>${order.optionName} : ${order.optionValue}</p>
											</c:if>
												<p>수량: ${order.quantity}개</p>
											</div>
										</div>
								</a></td>
								<td><span id="total-price"><fmt:formatNumber
											value="${order.amount}" groupingUsed="true" />원</span></td>
								<td>
									<c:choose>
										<c:when test="${index eq 0}">
										    <a href="${pageContext.request.contextPath}/order/cancelOrder.do?orderNo=${order.orderNo}"><button class="cancel-btn">취소신청</button></a>
										</c:when>
										<c:when test="${index ge 1 && index le 4}">
										    <a href="${pageContext.request.contextPath}/order/cancelOrder.do?orderNo=${order.orderNo}"><button class="cancel-btn">취소/환불신청</button></a>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
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
		</div>
	</section>

<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>