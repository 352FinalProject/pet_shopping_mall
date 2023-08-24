<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />
    <section class="common-section" id="#">
        <div class="common-title">마이페이지</div>
        <br>
        <div class="common-container">
            <div class="common-div">
                <div class="profile-div">
                    <div class="user-profile">
                        <div>
                            <img class="user-profile-img" src="${pageContext.request.contextPath}/resources/images/chat/chat.png" alt="User Profile">
                        </div>
                        <div class="user-info">
                            <div>
                                <p id="member-id">${myPage.name}</p>
                                <c:if test="${(myPage.subscribe) eq 'Y'}">
	                            <p>${myPage.name}님은 <span class="grade">우동친</span> 등급입니다</p>
                                </c:if>
                                <c:if test="${(myPage.subscribe) eq 'N'}">
	                            <p>${myPage.name}님은 <span class="grade">일반</span> 등급입니다</p>
                                </c:if>
                                <p>현재 포인트 : <span class="grade"><fmt:formatNumber value="${myPage.pointCurrent}"
										groupingUsed="true" /></span>점</p>
                            </div>
                            <div>
                                <a class="benefits-link" href="#">🔎 멤버쉽 혜택보기</a>
                                <a class="benefits-link" href="#" onclick="subscribe();">📌 구독하기</a>
                            </div>
                        </div>
                    </div>
                    <div class="options">
                        <div class="option"><a href="${pageContext.request.contextPath}/point/pointList.do">포인트내역</a></div>
                        <div class="option"><a href="${pageContext.request.contextPath}/member/myWishlist.do">찜한 상품</a></div>
                        <div class="option"><a href="#">쿠폰 0장</a></div>
                    </div>
                    <div class="recent-orders">
                        <div class="common-title">최근 1개월 주문내역</div>
                        <c:if test="${empty myPage.orderHistory}">
                        	<div class="order-div">최근 1개월 간 구매한 내역이 없습니다.</div>
                        </c:if>
                        <c:if test="${not empty myPage.orderHistory}">
                        	<div>
								<table id="order-table">
									<thead>
										<tr>
											<th>날짜</th>
											<th>주문번호</th>
											<th>상세내역</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${myPage.orderHistory}" var="order" varStatus="vs">
                        			<fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" var="formattedDate"/>
										<tr>
											<td>${formattedDate}</td>
											<td>${order.orderNo}</td>
											<td><a href="${pageContext.request.contextPath}/order/orderDetail.do?orderNo=${order.orderNo}">📜<a></td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
                        	</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </section>
<script>
	const subscribe = () => {
		if(confirm("정말 구독하시겠습니까?")) {
			IMP.request_pay({
				pay_method : 'card', // 기능 없음.
				merchant_uid: "order_monthly_0001", // 상점에서 관리하는 주문 번호
				name : '최초인증결제',
				amount : 1004, // 빌링키 발급과 함께 1,004원 결제승인을 시도합니다.
				customer_uid : 'your-customer-unique-id', // 필수 입력
				buyer_email : 'iamport@siot.do',
				buyer_name : '아임포트',
				buyer_tel : '02-1234-1234'
			}, function(rsp) {
				if ( rsp.success ) {
					alert('빌링키 발급 성공');
				} else {
					alert('빌링키 발급 실패');
				}
			});
		}
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />