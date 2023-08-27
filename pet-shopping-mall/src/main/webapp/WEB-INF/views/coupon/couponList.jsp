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
	<div class="common-container-side">
		<div class="common-div">
			<div class="service-util-div-sidebar">
				<table class="service-product-utility-sidebar">
					<thead>
						<tr>
							<th>내역</th>
							<th>발급일</th>
							<th>유효기간</th>
							<th>사용유무</th>
							<th>사용날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${memberCoupons}" var="coupon" varStatus="vs">
							<tr class="question-row">
								<td>${coupon.couponName}</td>
								<td><fmt:parseDate value="${coupon.createDate}" pattern="yyyy-MM-dd'T'HH:mm" var="couponCreateDate" />
								<fmt:formatDate value="${couponCreateDate}" pattern="yy/MM/dd HH:MM" /></td>
								<td><fmt:parseDate value="${coupon.endDate}" pattern="yyyy-MM-dd'T'HH:mm" var="couponEndDate" />
								<fmt:formatDate value="${couponEndDate}" pattern="yy/MM/dd HH:MM" /></td>
								<td><c:if test="${coupon.useStatus == 0}">미사용</c:if>
							    <c:if test="${coupon.useStatus == 1}">사용</c:if></td>
								<td><fmt:parseDate value="${coupon.useDate}" pattern="yyyy-MM-dd'T'HH:mm" var="couponUseDate" />
								<fmt:formatDate value="${couponUseDate}" pattern="yy/MM/dd HH:MM" /></td>
							</tr>
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