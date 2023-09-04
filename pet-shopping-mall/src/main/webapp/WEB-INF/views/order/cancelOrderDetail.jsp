<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
#cancel-btn{
	background: #5886d3;
	width: 100%;
	cursor: pointer;
}
#button-div {
	text-align: center;
	font-size: 24px;
}
#refund-success-div {
	margin-top: 50px;
}
</style>
<section class="common-section" id="#">
	<div class="common-title">취소 상세 내역</div>
	<div class="common-container">
		<div class="common-div">
			<div class="payment-div">
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
							 <span id="address">${cancelInfo.address}</span>
						</p>
					</div>
					<div>
						<p class="order-info-title">주문결제정보</p>
						<div class="payment-info2">
							<div class="product-price">
								<span class="price"><strong>주문번호</strong></span>
								<p>
									<span>${cancelInfo.orderNo}</span>
								</p>
							</div>
							<div class="product-price">
								<span>주문날짜</span>
								<p>
									<span>${cancelInfo.orderDate}</span>
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
									<c:set var="method" value="${cancelInfo.paymentMethod eq 1 ? '카카오페이' : '신용카드'}" />
									<span>${method}</span>
								</p>
							</div>
							<div class="product-price">
								<span>결제금액</span>
								<p>
									<span id="total-price"><fmt:formatNumber
											value="${cancelInfo.amount}" groupingUsed="true" /></span>
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
					<div id="button-div">
					<c:set var="index" value="${cancelInfo.orderStatus}"/>
					<c:choose>
						<c:when test="${index eq 5}">
							<div id="refund-success-div">환불이 완료된 주문입니다.</div>
						</c:when>
						<c:when test="${index eq 6}">
							<div id="refund-success-div">구매 확정된 주문이라 환불이 불가능합니다.</div>
						</c:when>
						<c:otherwise>
							<button class="btn" id="cancel-btn" onclick="cancelOrder('refund');">취소/환불신청</button>
						</c:otherwise>
					</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
<form:form id="cancelFrm" action="" method="POST">
	<input type="hidden" name="orderNo" value="${cancelInfo.orderNo}" />
	<input type="hidden" name="amount" value="${cancelInfo.amount}" />
	<input type="hidden" name="isRefund" value="" />
</form:form>
</section>
<script>

const cancelOrder = (text) => {
	if(confirm("정말 주문을 취소하시겠습니까?\n사용하신 포인트와 쿠폰은 반환되지 않습니다.") && text === 'cancel') {
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
		
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>