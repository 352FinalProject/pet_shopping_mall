<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/serviceCenter.css" />
<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h2 class="mt-3">1:1 문의 내역 (관리자)</h2>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/admin/adminQuestionSearch.do"></a></li>
	</ol>
	<div class="card mb-4">
		<div class="card-body">
			<div class="admin-member-search-container">
				<form:form name="questionSearchFrm"
					action="${pageContext.request.contextPath}/admin/adminQuestionSearch.do"
					method="get">
					<div class="admin-member-search-container">
						<form:form name="adminMemberSearchFrm"
							action="${pageContext.request.contextPath}/admin/adminMemberSearchByNameOrId.do"
							method="get">
							<div class="input-group">
								<input type="text" id="searchKeyword" name="searchKeyword" placeholder="제목 또는 내용" class="adminInput">
								<input type="submit" value="검색" class ="btn btn-secondary">
							</div>
						</form:form>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<div class="card mb-4">
		
		<div class="card-body">
			<table id="datatablesSimple">
				<thead>
					<tr>
						<th>번호</th>
						<th>상태</th>
						<th>아이디</th>
						<th>제목</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${questions}" var="question" varStatus="vs">
						<tr class="question-row">
							<td><a href="${pageContext.request.contextPath}/admin/adminQuestionDetail.do?questionId=${question.questionId}">${question.questionId}</a>
							</td>
							<td><a href="${pageContext.request.contextPath}/admin/adminQuestionDetail.do?questionId=${question.questionId}">
				                <c:if test="${question.answerCount <= 0}"><span style="color: #c8c8c8;">답변대기</span></c:if>
				                <c:if test="${question.answerCount >= 1}">답변완료</c:if>
							<td><a
								href="${pageContext.request.contextPath}/admin/adminQuestionDetail.do?questionId=${question.questionId}">${question.questionMemberId}</a></td>
							<td><a
								href="${pageContext.request.contextPath}/admin/adminQuestionDetail.do?questionId=${question.questionId}">${question.questionTitle}</a></td>
							<td class="qna-date"><a
								href="${pageContext.request.contextPath}/admin/adminQuestionDetail.do?questionId=${question.questionId}">
									<fmt:parseDate value="${question.questionCreatedAt}"
										pattern="yyyy-MM-dd'T'HH:mm" var="questionCreatedAt" /> <fmt:formatDate
										value="${questionCreatedAt}" pattern="yy/MM/dd" />
							</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>