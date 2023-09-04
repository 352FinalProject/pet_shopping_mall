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

<%-- 1:1 문의 상세 조회 (예라) --%>
<section class="common-section" id="#">
	<div class="common-title">1:1 문의 상세 내역</div>
	<div class="common-container">
		<div class="common-div">
			<div class="qna-create">
				<div class="input-container">
					<!-- 질문 상세 내역 -->
					<table class="table_row_a">
						<tr>
							<th>분류</th>
							<td><input type="text" name="questionCategory"
								id="questionCategory" value="${questions.questionCategory}"
								required readonly></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="questionMemberId"
								id="questionMemberId" value="${questions.questionMemberId}"
								required readonly /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="email" name="questionEmail"
								id="questionEmail" value="${questions.questionEmail}" required
								readonly></td>
						</tr>
						<tr>
							<th>사진첨부</th>
							<td>
								<div class="detail-upload" style="position: relative;">
								    <input type="text" name="imageOriginalFilename" 
								           value="${questionDetails.attachments[0].imageOriginalFilename}" 
								           required readonly style="cursor: pointer;">
								    <a href="${pageContext.request.contextPath}/servicecenter/fileDownload.do?questionId=${questions.questionId}" id="downloadLink" 
								       style="position: absolute; top: 0; right: 0; bottom: 0; left: 0; cursor: pointer;"></a>
								</div>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" name="questionTitle"
								id="questionTitle" readonly value="${questions.questionTitle}"
								required></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea name="qna-content" id="questionContent"
									rows="10" cols="59" readonly style="resize: none;">
								${questions.questionContent}</textarea></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 질문 내용 -->
		<div class="content-container">
			<div class="anw-create">
				<table>
					<div class="anw-regdate">
						<br />
						<fmt:parseDate value="${answers.answerCreatedAt}"
							pattern="yyyy-MM-dd'T'HH:mm" var="answerCreatedAt" />
						답변 등록일
						<fmt:formatDate value="${answerCreatedAt}" pattern="yy/MM/dd" />
					</div>
					<tr>
						<th>A</th>
						<td><textarea name="answerContent" id="answerContent"
								readonly style="height: 160px; resize: none;">${answers.answerContent}</textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<!-- 사용자 버튼 -->
		<div class="qna-create-btn">
			<form
				action="${pageContext.request.contextPath}/servicecenter/inquiry/questionList.do"
				class="form-inline">
				<button class="qna-btn-reset" type="submit">목록</button>
			</form>
			<button type="button" onclick="QuestionDelete();"
				class="qna-btn-reset">삭제하기</button>
			<c:if test="${empty answers.answerContent}">
				<form
					action="${pageContext.request.contextPath}/servicecenter/inquiry/questionUpdate.do?questionId=${questions.questionId}">
					<input type="hidden" name="questionId"
						value="${questions.questionId}">
					<button class="qna-btn-create" type="submit">수정하기</button>
				</form>
			</c:if>
		</div>
	</div>
</section>
<!-- 질문 삭제 폼 -->
<form:form name="QuestionDeleteFrm"
	action="${pageContext.request.contextPath}/servicecenter/inquiry/DeleteQuestion.do"
	method="POST">
	<input type="hidden" name="questionId" value="${questions.questionId}" />
</form:form>
</section>

<!-- 댓글 삭제 폼 -->
<form:form name="AnswerDeleteFrm"
	action="${pageContext.request.contextPath}/servicecenter/inquiry/answerDelete.do"
	method="POST">
	<input type="hidden" name="answerId" value="${answers.answerId}" />
	<input type="hidden" name="questionId" value="${questions.questionId}" />
</form:form>
<script>
// 문의글 삭제 알림
const QuestionDelete = () => {
	if(confirm("질문을 삭제하시겠습니까?")) {
		document.QuestionDeleteFrm.submit();
	}
};

//댓글 삭제 알림
const AnswerDelete = () => {
	if(confirm("댓글을 삭제하시겠습니까?")) {
		document.AnswerDeleteFrm.submit();
	}
};

// 댓글 삭제 히든창, 포커스
function showEditBox() {
    document.querySelector('.hidden-textbox').style.display = 'block';
    document.getElementById('editComment').focus();
}

// 이미지 다운로드
</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />