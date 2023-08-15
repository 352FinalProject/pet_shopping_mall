<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 1:1 문의 상세 조회 (예라) --%>
<section class="common-section" id="#">
	<div class="common-title">1:1 문의 상세 내역</div>
	<sec:authentication property="authorities" />
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
								<c:forEach items="${attachments}" var="attachment" varStatus="vs">
									${attachment.imageOriginalFilename}
								</c:forEach>
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
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<!-- 댓글 기능 -->
					<div class="anw-create-btn">
						<!-- 댓글 삭제 -->
						<button type="button" onclick="AnswerDelete();"
							class="anw-btn-reset">댓글삭제</button>
						<!-- 댓글 수정 -->
						<button class="anw-btn-create" type="button"
							onclick="showEditBox();">댓글수정</button>
						<form:form
							action="${pageContext.request.contextPath}/servicecenter/inquiry/answerUpdate.do?questionId=${questions.questionId}"
							method="post">
							<div class="hidden-textbox" style="display: none;">
								<textarea id="editComment" name="answerContent"
									style="position: absolute; border: 1px solid #c8c8c8; background: #f5f5f5; margin-left: -621px; margin-top: -130px; width: 700px; height: 110px;"></textarea>
								<input type="hidden" name="questionId"
									value="${questions.questionId}" /> <input type="hidden"
									name="answerId" value="${answers.answerId}" />
								<button onclick="submitEdit();" name="" class="editComment">수정하기</button>
							</div>
						</form:form>
					</div>
					<!-- 댓글 작성 -->
					<form:form
						action="${pageContext.request.contextPath}/servicecenter/inquiry/answerCreate.do"
						method="post">
						<td><textarea name="answerContent" id="answerContent"
								style="height: 100px; resize: none;"></textarea></td>
						<input type="hidden" name="questionId"
							value="${questions.questionId}">
						<input type="hidden" name="answerAdminName"
							value="${answers.answerAdminName}">
						<div class="anw-create2">
							<button class="anw-btn-create2" type="submit">댓글작성</button>
						</div>
					</form:form>
				</sec:authorize>
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
</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />