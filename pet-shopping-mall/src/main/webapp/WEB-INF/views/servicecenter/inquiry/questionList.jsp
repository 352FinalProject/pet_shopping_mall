<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<%-- 1:1 문의 내역 (예라) --%>
<section class="common-section" id="common-section-List">
	<div class="common-title">1:1 문의 내역</div>
	<div class="common-container">
		<div class="common-div">
			<div class="service-search">
				<img src="${pageContext.request.contextPath}/resources/images/home/search.png" alt="">
				<input type="text" name="service-search" id="service-search" value="" placeholder="제목, 내용" required>
			</div>
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
							<tr class="question-row">
								<td>
									<a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.id}">${question.id}</a>
								</td>
								<td>
									<a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.id}">
									<c:if test="${question.id eq 0}">답변대기</c:if>
									<c:if test="${question.id gt 0}">답변완료</c:if></a>
								</td>
								<td><a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.id}">${question.title}</a></td>
								<td class="qna-date">
									<a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.id}">
									<fmt:parseDate value="${question.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate" />
									<fmt:formatDate value="${regDate}" pattern="yy/MM/dd" /></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</section>
<script>
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />