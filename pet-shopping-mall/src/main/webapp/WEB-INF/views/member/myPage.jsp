<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />
<style>
/* 팝업 스타일 */
.popup-container {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    justify-content: center;
    align-items: center;
}

.popup-content {
    background-color: white;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
    max-width: 400px; /* 팝업 창 최대 너비 설정 */
    width: 90%; /* 팝업 창 너비 설정 */
    text-align: center;
    font-size: 18px;
}

#closePopupBtn {
    margin-top: 15px;
    padding: 8px 15px;
    background-color: #f0f0f0;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

/* 호버 효과 */
.benefits-link:hover,
#closePopupBtn:hover {
    background-color: #e0e0e0;
}
</style>
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
                                <a class="benefits-link" id="benefits-popup" href="#">🔎 멤버쉽 혜택보기</a>
                                <a class="benefits-link" href="#" onclick="subscribe();">📌 구독하기</a>
                            </div>
                            <!-- 팝업 컨테이너 -->
						    <div class="popup-container" id="popupContainer">
						        <div class="popup-content">
						            <h2>🎁 <span style="color: #01A9DB;">우동친</span>만의 특별한 멤버쉽 혜택 🎁</h2>
						            <img src="${pageContext.request.contextPath}/resources/images/상품/gift.png" />
						            <div>1. 배송비 무료</div>
						            <div>2. 포인트 3% 추가 적립</div>
						            <button id="closePopupBtn">닫기</button>
						        </div>
						    </div>
                        </div>
                    </div>
                    <div class="options">
                        <div class="option"><a href="${pageContext.request.contextPath}/point/pointList.do">포인트내역</a></div>
                        <div class="option"><a href="${pageContext.request.contextPath}/wishlist/myWishlist.do">찜한 상품</a></div>
                        <div class="option"><a href="${pageContext.request.contextPath}/coupon/couponList.do?couponId=${coupon.couponId}">쿠폰 ${couponCount}장</a></div>
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
			// 정기결제 코드
		}
	};
	
	const benefitsPopupLink = document.getElementById("benefits-popup");
	const closePopupBtn = document.getElementById("closePopupBtn");
	const popupContainer = document.getElementById("popupContainer");

	benefitsPopupLink.addEventListener("click", (e) => {
	    e.preventDefault(); // 기본 링크 동작 취소
	    popupContainer.style.display = "flex";
	});

	closePopupBtn.addEventListener("click", () => {
	    popupContainer.style.display = "none";
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />