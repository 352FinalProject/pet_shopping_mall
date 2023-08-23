<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp"></jsp:include>
<%-- 쿠폰 내역 (예라) --%>
<section class="common-section" id="common-section-List">
	<div class="common-title">쿠폰 내역</div>
	<div class="common-container">
		<div class="common-div">
			<div class="service-util-div-point">
				<table class="service-product-utility-point">
					<thead>
						<tr>
							<th>번호</th>
							<th>내역</th>
							<th>발급일</th>
							<th>유효기간</th>
							<th>사용날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${memberCoupons}" var="coupon" varStatus="vs">
							<sec:authentication var="currentUsername" property="principal.username"/>
								<c:if test="${coupon.pointMemberId == currentUsername}">
									<tr class="question-row">
										<td>${coupon.couponId}</td>
										<td>${coupon.pointType}</td>
										<td>
										    <c:choose>
										        <c:when test="${coupon.pointAmount >= 0}">
										            <span class="plus">+ ${coupon.pointAmount}</span>
										        </c:when>
										        <c:otherwise>
										            <span class="minus">${coupon.pointAmount}</span>
										        </c:otherwise>
										    </c:choose>
										</td>
										<td>${coupon.pointCurrent}</td>
										<td class="qna-date">
											<input type="hidden" name="pointDate" value="${coupon.pointDate}" />
											<a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${coupon.pointDate}">
											<fmt:parseDate value="${coupon.pointDate}" pattern="yyyy-MM-dd'T'HH:mm" var="pointDate" />
											<fmt:formatDate value="${pointDate}" pattern="yy/MM/dd" /></a>
										</td>
									</tr>
								</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
<nav aria-label="...">
  	<ul class="pagination pagination-sm">
	    <c:forEach begin="1" end="${totalPages}" var="pageNumber">
	        <li class="page-item ${page == pageNumber ? 'active' : ''}">
	            <a class="page-link" href="${pageContext.request.contextPath}/servicecenter/inquiry/questionList.do?page=${pageNumber}">
                    <span class="page-number">${pageNumber}</span>
                </a>
	        </li>
	    </c:forEach>
	</ul>
</nav>
</section>
<script>
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />