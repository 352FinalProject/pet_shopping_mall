<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
									<td><a
										href="${pageContext.request.contextPath}/order/orderDetail.do?orderNo=${order.orderNo}">
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
									</a></td>
									<td><span id="total-price"><fmt:formatNumber
												value="${entry.key.amount}" groupingUsed="true" />원</span></td>
									<td>
										<p>${status[index]}</p>
									</td>
								</tr>
								</c:forEach>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
			<c:if test="${empty orderDetail}">
				<div class="empty-message">조회된 주문 내역이 없습니다.</div>
			</c:if>
			</div>
			<div class="payment-div">
				<c:if test="${not empty payment}" >
				<div class="payment-left">
					<sec:authentication property="principal" var="loginMember" />
					<c:set var="amount" value="0" />
					<div class="order-info">
						<div>
							<p class="order-info-title">주문자</p>
						</div>
						<p>${loginMember.name}</p>
						<p>${loginMember.phone}</p>
					</div>
					<div>
						<div class="flex-box">
							<p class="order-info-title">배송지</p>
							<button class="cart-btn-update">수정</button>
						</div>
						<p id="">${loginMember.name}</p>
						<p id="phone">${loginMember.phone}</p>
						<p>
							[<span id="zip-code">818181</span>]<span id="address">${loginMember.address}</span>
						</p>
					</div>
					<div>
						<p class="order-info-title">주문결제정보</p>
						<div class="payment-info2">
							<div class="product-price">
								<span class="price"><strong>주문번호</strong></span>
								<p>
									<span>${orderDetail.orderNo}</span>
								</p>
							</div>
							<div class="product-price">
								<span>주문날짜</span>
								<p>
									<span>${orderDetail.orderDate}</span>
								</p>
							</div>
							<div class="product-price">
								<span>결제일시</span>
								<p>
									<span>${cancelInfo.paymentDate}</span>
								</p>
							</div>
							<div class="product-price">
								<span>결제수단</span>
								<p>
									<c:set var="method" value="${cancelInfo.paymentMethod eq 1 ? '카드' : '현금'}" />
									<span>${method}</span>
								</p>
							</div>
							<div class="product-price">
								<span>결제금액</span>
								<p>
									<span id="total-price"><fmt:formatNumber
											value="${orderDetail.amount}" groupingUsed="true" /></span>
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="payment-right">
					<p class="order-info-title">결제금액</p>
					<div class="payment-info">
						<div>
							<div class="product-price">
								<span class="price"><strong>상품금액</strong></span>
								<p>
									<span id="total-price"><fmt:formatNumber
											value="${cancelInfo.totalPrice}" groupingUsed="true" /></span>원
								</p>
							</div>
							<div class="product-price">
								<span>배송비</span>
								<p>
									<span style="color: red;">(+)</span><span id="delivery-fee">3,000</span>원
								</p>
							</div>
							<div class="product-price">
								<span>할인금액</span>
								<p>
									<span style="color: red;">(-) <span id="discount"><fmt:formatNumber
											value="${cancelInfo.discount}" groupingUsed="true" /></span>원</span>
								</p>
							</div>
							<div class="product-price">
								<span>쿠폰</span>
								<p>
									<span style="color: red;">(-) <span id="discount">원</span></span>
								</p>
							</div>
						</div>
					</div>
					<div class="payment-info2">
						<div class="product-price">
							<strong class="price-title">최종 결제 금액</strong>
							<p class="price">
								<span id="amount"><fmt:formatNumber value="${cancelInfo.amount}"
										groupingUsed="true" /></span>원
							</p>
						</div>
					</div>
				</div>
			</div>
			</c:if>
		</div>
	</div>
</section>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />