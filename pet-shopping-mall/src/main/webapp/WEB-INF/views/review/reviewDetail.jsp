<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 리뷰 상세 조회 (혜령) --%>
<section class="common-section" id="#">
	<div class="common-title">리뷰 상세</div>
	<div class="common-container">
		<div class="common-div">
			<div class="review-create">
				<div class="input-container">
					<!-- 질문 상세 내역 -->
					<table class="table_row_a">
						<tr>
							<th>제목</th>
							<td><input type="text" name="questionTitle"
								id="reivewTitle" readonly value="${reviews.reviewTitle}"
								required></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea name="review-content" id="reviewContent"
									rows="10" cols="59" readonly style="resize: none;">
								${reviews.reviewContent}</textarea></td>
						</tr>
						<tr>
							<th>이미지</th>
						    <td>
						    </td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="content-container">
			<div class="review-create">
				<table>
					<tr>
						<td> 리뷰작성일
							<fmt:parseDate value="${reviews.reviewCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
							<fmt:formatDate value="${createdAt}" pattern="yy/MM/dd HH:mm"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="review-create-btn">
			<form
				action="${pageContext.request.contextPath}/review/reviewList.do"
				class="form-inline">
				<button class="review-btn-reset" type="submit">목록</button>
			</form>
			<button type="button" onclick="reviewDelete();"
				class="review-btn-reset">삭제하기</button>
			<c:if test="${!empty reviews.reviewContent}">
				<form
					action="${pageContext.request.contextPath}/review/reviewUpdate.do?reviewId=${reviews.reviewId}">
					<input type="hidden" name="reviewId"
						value="${reviews.reviewId}">
					<button class="review-btn-create" type="submit">수정하기</button>
				</form>
			</c:if>
		</div>
	</div>
<form:form name="reviewDeleteFrm"
	action="${pageContext.request.contextPath}/review/reviewDelete.do"
	method="POST">
	<input type="hidden" name="reviewId" value="${reviews.reviewId}" />
</form:form>
</section>

<script>
// 리뷰 삭제
const reviewDelete = () => {
	if(confirm("작성한 리뷰를 삭제하시겠습니까?")) {
		document.reviewDeleteFrm.submit();
	}
};
</script>



<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />