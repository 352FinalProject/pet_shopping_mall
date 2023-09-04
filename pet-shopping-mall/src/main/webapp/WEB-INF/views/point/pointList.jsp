<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp"></jsp:include>
<%-- 포인트 내역 (예라) --%>
<section class="common-section" id="common-section-List">
	<div class="common-title">포인트 내역</div>
	<div class="common-container-side">
		<div class="common-div">
			<div class="service-util-div-sidebar">
				<table class="service-product-utility-sidebar">
					<thead>
						<tr>
							<th>번호</th>
							<th>내역</th>
							<th>적립/사용</th>
							<th>잔액</th>
							<th>날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${points}" var="point" varStatus="vs">
							<sec:authentication var="currentUsername" property="principal.username"/>
								<c:if test="${point.pointMemberId == currentUsername}">
									<tr class="question-row">
										<td>${point.pointId}</td>
										<td>${point.pointType}</td>
										<td>
										    <c:choose>
										        <c:when test="${point.pointAmount >= 0}">
										            <span class="plus">+ ${point.pointAmount}</span>
										        </c:when>
										        <c:otherwise>
										            <span class="minus">${point.pointAmount}</span>
										        </c:otherwise>
										    </c:choose>
										</td>
										<td>${point.pointCurrent}</td>
										<td class="qna-date">
											<input type="hidden" name="pointDate" value="${point.pointDate}" />
											<a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${point.pointDate}">
											<fmt:parseDate value="${point.pointDate}" pattern="yyyy-MM-dd'T'HH:mm" var="pointDate" />
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
	            <a class="page-link" href="${pageContext.request.contextPath}/point/pointList.do?page=${pageNumber}">
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