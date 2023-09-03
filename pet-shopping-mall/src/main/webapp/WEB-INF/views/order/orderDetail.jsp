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
/* 아코디언 스타일 */
.detail-row {
    display: none;
    transition: max-height 0.3s ease; /* 펼치기/접기 애니메이션 효과 추가 */
}

.detail-row.show {
    display: table-row;
}

.detail-content {
    padding: 10px;
    background-color: #f0f0f0;
}

/* 호버 효과 */
.order-row:hover {
    cursor: pointer;
    background-color: #f5f5f5;
}
</style>
<section class="common-section" id="common-section-List">
	<div class="common-title">주문 상세 내역</div>
	<div class="common-container-side">
		<div class="common-div">
				<div class="order">
						<div class="service-util-div-sidebar-cancel">
							<table class="service-product-utility-sidebar" id="order-table">
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
						</div>
						<c:if test="${not empty orderDetail}">
							<sec:authentication property="principal" var="loginMember" />
							<c:forEach var="orderMap" items="${orderDetail}">
								<c:forEach var="entry" items="${orderMap}">
								<c:set var="index" value="${entry.key.orderStatus}"/>
								<c:set var="option" value="${entry.key.optionName}" />
								<c:set var="amount" value="${entry.key.amount}" />
								<fmt:formatDate value="${entry.key.orderDate}" pattern="yyyy-MM-dd" var="formattedDate"/>
								<tr class="order-row" data-payment='${entry.value}'>
									<td>${formattedDate}</td>
									<td>
										<p>${entry.key.orderNo}</p>
									</td>
									<td>
										<div class="flex">
											<img src="${pageContext.request.contextPath}/resources/upload/product/${entry.key.thumbnail}" width="110px">
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
										<c:set var="compositeKey" value="${entry.key.orderId}-${entry.key.productDetailId}-${entry.key.productId}" />
										<c:choose>
										    <c:when test="${(status[index] == '배송완료' || status[index] == '구매확정') && reviewWrite[compositeKey] == false}">
										        <p>${status[index]}</p>
										        <form action="${pageContext.request.contextPath}/review/reviewCreate.do" method="GET">
										            <input type="hidden" name="productDetailId" value="${entry.key.productDetailId}">
										            <input type="hidden" name="productId" value="${entry.key.productId}">
										            <input type="hidden" name="orderId" value="${entry.key.orderId}">
										            <button class="review-btn" type="submit">리뷰쓰기</button>
										        </form>
										    </c:when>
										    <c:when test="${status[index] == '구매확정' && reviewWrite[compositeKey] == true}">
										        <p>구매확정</p>
										    </c:when>
										    <c:otherwise>
										        <p>${status[index]}</p>
										    </c:otherwise>
										</c:choose>
									</td>
								</tr>
								<c:if test="${payment eq null}">
								<tr class="detail-row">
							        <td colspan="5">
							            <div class="detail-content">
							            	<c:set var="paymentMethod" value="${entry.value.paymentMethod eq 1 ? '카카오페이' : '신용카드'}" />
							                <p>결제 방법 : ${paymentMethod}</p>
							                <p>결제 날짜 : ${entry.value.paymentDate}</p>
							                <p>결제 금액 : <span><fmt:formatNumber value="${entry.value.amount}"
										groupingUsed="true" /></span>원</p>
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
	</div>
</section>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const orderRows = document.querySelectorAll(".order-row");

    orderRows.forEach(row => {
        row.addEventListener("click", function() {
            const detailRow = row.nextElementSibling;
            if (detailRow.classList.contains("detail-row")) {
                detailRow.classList.toggle("show");
            }
        });
    });
});

//페이지가 로드될 때 리뷰 작성 상태 확인
$(document).ready(function() {
    checkReviewStatus();
});

// 리뷰 작성 상태를 서버에서 확인
function checkReviewStatus() {
    $.ajax({
        url: '${pageContext.request.contextPath}/order/orderDetail',
        type: 'GET',
        success: function(response) {
            if (response.reviewWrite) {
                $(".review-btn").hide(); // 리뷰를 이미 작성했다면 버튼 숨기기
            } else {
                $(".review-btn").show(); // 리뷰를 작성하지 않았다면 버튼 표시
            }
        }
    });
}


</script>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />