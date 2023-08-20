<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%-- 1:1 문의 내역 (예라) --%>
<section class="common-section" id="common-section-List">

	<div class="common-title">1:1 문의 내역</div>
	<div class="common-container">
		<div class="common-div">
			<form:form name="questionSearchFrm" 
				action="${pageContext.request.contextPath}/servicecenter/inquiry/questionSearch.do" method="get">
				<div class="service-search">
					<img src="${pageContext.request.contextPath}/resources/images/home/search.png" alt="">
					<input type="text" name="searchKeyword" id="searchKeyword" value="" placeholder="제목 또는 내용" required>
				<div class="searchKeyword2">
       			<input type="submit" id="searchKeyword2" value="검색">
       			</div>
			</div>
			</form:form>
			<form action="${pageContext.request.contextPath}/servicecenter/inquiry/questionCreate.do" class="form-inline">
				<button class="btn-add">1:1문의 쓰기</button>
			</form>
			<div class="service-util-div">
				<table class="service-product-utility">
					<thead>
						<tr>
							<th>번호</th>
							<th>상태</th>
							<th>제목</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${questions}" var="question" varStatus="vs">
							<sec:authentication var="currentUsername" property="principal.username"/>
								<c:if test="${question.questionMemberId == currentUsername}">
							        <tr class="question-row">
							            <td>
							                <a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.questionId}">${question.questionId}</a>
							            </td>
							            <td>
							                <a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.questionId}">
							                <c:if test="${question.answerCount <= 0}"><span>답변대기</span></c:if>
							                <c:if test="${question.answerCount >= 1}">답변완료</c:if>
							            </td>
							            <td><a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.questionId}">${question.questionTitle}</a></td>
							            <td class="qna-date">
							              	<fmt:parseDate value="${question.questionCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="questionCreatedAt" />
											<fmt:formatDate value="${questionCreatedAt}" pattern="yy/MM/dd" />
							            </td>
							        </tr>
							    </c:if>
						</c:forEach>
							<c:forEach items="${questions}" var="question" varStatus="vs">
								<sec:authorize access="hasRole('ROLE_ADMIN')">
							        <tr class="question-row">
							            <td>
							                <a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.questionId}">${question.questionId}</a>
							            </td>
							            <td>
							                <a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.questionId}">
							                <c:if test="${question.answerCount <= 0}"><span>답변대기</span></c:if>
							                <c:if test="${question.answerCount >= 1}">답변완료</c:if>
							            </td>
							            <td><a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.questionId}">${question.questionTitle}</a></td>
							            <td class="qna-date">
							              	<fmt:parseDate value="${question.questionCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="questionCreatedAt" />
											<fmt:formatDate value="${questionCreatedAt}" pattern="yy/MM/dd" />
							            </td>
							        </tr>
							   </sec:authorize>
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