<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
	max-width: 600px; /
	width: 90%;
	text-align: center;
	align-items: center;
	font-size: 18px;
	display: flex;
	flex-direction: column;
}

.popup-content img {
	width: 60%;
}

#closePopupBtn {
	margin-top: 15px;
	padding: 8px 15px;
	background-color: #f0f0f0;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.benefits-link:hover, #closePopupBtn:hover {
	background-color: #e0e0e0;
}

.myPage-info{
	display: flex;
}
</style>
<section class="common-section" id="#">
	<div class="common-title">마이페이지</div>
	<br>
	<div class="common-container">
		<div class="common-div">
			<div class="profile-div">
				<div class="user-profile">
					<sec:authentication property="principal" var="loginMember" />
					<div>
						<img class="user-profile-img"
							src="${pageContext.request.contextPath}/resources/images/chat/chat.png"
							alt="User Profile">
					</div>
					<div class="user-info">
						<div>
							<p id="member-id">${myPage.memberId}</p>
							<c:if test="${(myPage.subscribe) eq 'Y'}">
								<p>${myPage.name}님은
									<span class="grade">우동친</span> 등급입니다
								</p>
							</c:if>
							<c:if test="${(myPage.subscribe) eq 'N'}">
								<p>${myPage.name}님은
									<span class="grade">일반</span> 등급입니다
								</p>
							</c:if>
							<p>
								현재 포인트 : <span class="grade"><fmt:formatNumber
										value="${myPage.pointCurrent}" groupingUsed="true" /></span>점
							</p>
						</div>
						<div>
							<a class="benefits-link" id="benefits-popup" href="#">🔎 멤버쉽
								혜택보기</a>
							<c:if test="${myPage.subMember eq null}">
								<a class="benefits-link" href="#" onclick="subscribes();">📌
									구독하기</a>
							</c:if>
							<c:if test="${myPage.subMember ne null}">
								<c:choose>
									<c:when
										test="${myPage.subMember.scheduleStatus eq 'scheduled'}">
										<p>다음 달 멤버쉽 결제 날짜 : ${myPage.subMember.scheduleAt}</p>
										<p>결제 예정 금액 : ${myPage.subMember.amount}원</p>
										<form:form method="POST"
											action="${pageContext.request.contextPath}/payment/unsubscribe.do">
											<input type="hidden" name="customerUid"
												value="${myPage.memberId}" />
											<button type="submit" class="review-btn">멤버쉽 해제</button>
										</form:form>
									</c:when>
									<c:when test="${myPage.subMember.scheduleStatus eq 'cancel'}">
										<p>
											남은 멤버쉽 기간 : <span> ~ <fmt:formatDate
													value="${myPage.subMember.scheduleAt}" pattern="yyyy-MM-dd" /></span>
										</p>
									</c:when>
								</c:choose>
							</c:if>
						</div>
						<!-- 팝업 컨테이너 -->
						<div class="popup-container" id="popupContainer">
							<div class="popup-content">
								<h2>
									🎁 <span style="color: #01A9DB;">우동친</span>만의 특별한 멤버쉽 혜택 🎁
								</h2>
								<img
									src="${pageContext.request.contextPath}/resources/images/배너/membership_benefit.png" />
								<button id="closePopupBtn">닫기</button>
							</div>
						</div>
					</div>
				</div>
				<div class="options">
					<div class="option">
						<a href="${pageContext.request.contextPath}/point/pointList.do">포인트내역</a>
					</div>
					<div class="option">
						<a
							href="${pageContext.request.contextPath}/wishlist/myWishlist.do">찜한
							상품</a>
					</div>
					<div class="option">
						<a href="${pageContext.request.contextPath}/coupon/couponList.do">쿠폰
							${couponCount}장</a>
					</div>
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
									<c:forEach items="${myPage.orderHistory}" var="order"
										varStatus="vs">
										<fmt:formatDate value="${order.orderDate}"
											pattern="yyyy-MM-dd" var="formattedDate" />
										<tr>
											<td>${formattedDate}</td>
											<td>${order.orderNo}</td>
											<td><a
												href="${pageContext.request.contextPath}/order/orderDetail.do?orderNo=${order.orderNo}">📜</a></td>
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
	<nav aria-label="...">
		<ul class="myPage-info">
			<c:forEach begin="1" end="${totalPages}" var="pageNumber">
				<li class="myPage-item ${page == pageNumber ? 'active' : ''}"><a
					class="myPage-link"
					href="${pageContext.request.contextPath}/member/myPage.do?page=${pageNumber}">
						<span class="myPage-number">${pageNumber}</span>
				</a></li>
			</c:forEach>
		</ul>
	</nav>
</section>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>

let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");

$(function() {
    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
});

function subscribes() {
    if (confirm("구독을 진행하시겠습니까?")) {
        IMP.init('imp60204862');
        IMP.request_pay({
            pg: "html5_inicis",
            pay_method: "card",
            amount: 1000,
            name : "정기결제",
            merchant_uid: new Date().getTime(), 
            customer_uid: '${myPage.memberId}', 
        }, function (response) {
            console.log(response);
            if (response.success) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/payment/startScheduler.do',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        "customerUid": '${myPage.memberId}',
                        "amount": 1000,
                        "merchantUid": "bill"+new Date().getTime()
                    }),
                    success(response) {
                        alert('다음 결제일이 등록되었습니다.');
                    }
                });
            } else {
                alert('빌링키 발급 실패! 관리자에게 문의하세요.');
            }
        });
    }
}
	
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