<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<%-- 1:1 문의 상세 조회 (예라) --%>
<style>
/* 공통 스타일 */
.common-section {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	margin-left: 350px;
    margin-top: 120px;
}

.common-container {
	width: 1200px;
	margin-top: 100px;
}

.common-div {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.common-title {
	font-size: 28px;
	margin-bottom: 50px;
	line-height: 1.2;
	font-weight: 500;
	color: #333;
}

.anw-create th {
    color: #ebdb4b;
}


/*1:1 상세 내역 조회 아이디 폼, 파일 폼*/
.qna-create input[type="text"], .qna-create input[type="email"]{
	width: 450px;
	border: 1px solid #c8c8c8;
	height: 30px;
	margin-top: 12px;
	margin-bottom: 12px;
	margin-right: 10px;
	margin-left: 40px;
	padding: 9px;
}

.editComment {
    width: 75px;
    height: 30px;
    border: none;
    border-radius: 5px;
    color: #fff;
    background: #58ACFA;
    cursor: pointer;
 }

.qna-create input[type="file"] {
	margin-left: -167px;
}

.anw-regdate {
	text-align: left;
	font-size: 14px;
	margin-bottom: 15px;
	margin-left: 18px;
	color: #828282;
}

/*1:1 상세 내역 조회 내용*/

/**/
.qna-create input[name="content"] {
	height: 210px;
}

.qna-create th {
	text-align: left;
	font-size: 15px;
	vertical-align: middle;
}

.qna-create2 th {
	text-align: left;
	font-size: 15px;
	vertical-align: middle;
}

/* 1:1 상세 내역 내용 style */
.qna-create textarea[name="questionContent"] {
	width: 700px;
	height: 270px;
	border: 1px solid #c8c8c8;
	display: block;
	resize: none;
}

/* 1:1 작성 내용 style */
.qna-create2 textarea[name="questionContent"] {
	width: 700px;
	height: 270px;
	border: 1px solid #c8c8c8;
	display: block;
	resize: none;
}

.input-container {
	border: 1px solid #c8c8c8;
	padding: 20px;
	margin-bottom: 20px;
	width: 700px;
    text-align: center; /* 가운데 정렬 */
}

.input-container table {

}

.content-container {
	display: flex;
	justify-content: center;
	margin-top: -30px;
}

/* 파일첨부 버튼 */
.btn-upload {
	font-size: 14px;
	width: 90px;
	height: 30px;
	background: #fff;
	border: 1px solid #c8c8c8;
	font-weight: 500;
	cursor: pointer;
	display: flex;
	margin-left: -100px;
	align-items: center;
	justify-content: center; &: hover { background : #58ACFA;
	color: #fff;
}
}

.qna-create textarea {
	padding: 10px;
	border: 1px solid #c8c8c8;
	margin-left: 30px;
	
}

.qna-create textarea {
	padding: 10px;
	border: 1px solid #c8c8c8;
	
}

#questionContent {
	margin-top: 11px;	
}

/* 1:1 작성 작성하기 버튼*/
.qna-btn-create {
	width: 150px;
	height: 50px;
	border-radius: 5px;
	border: none;
	font-size: 15px;
	color: #fff;
	background: #58ACFA;
	cursor: pointer;
}

/**/
.anw-create [name="answerContent"] {
	width: 700px;
	border: 1px solid #c8c8c8;
	height: 30px;
	margin: 10px;
	padding: 10px;
}

.anw-create-btn {
    display: flex;
    justify-content: flex-end;
    gap: 15px;
    margin-top: 15px;
    margin-bottom: 10px;
}
.qna-create-btn {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 30px;
    margin-bottom: 80px;
}
.anw-create2 {
    text-align: right;
}
.anw-btn-create2 {
    width: 75px;
    height: 30px;
    border: none;
    border-radius: 5px;
    color: #fff;
    background: #58ACFA;
    cursor: pointer;
    margin-right: 14px;
}

.anw-btn-reset, .anw-btn-create {
    width: 75px;
    height: 30px;
    border: none;
    border-radius: 5px;
    color: #fff;
    background: #c8c8c8;
    cursor: pointer;
}

.qna-btn-reset {
    width: 150px;
    height: 50px;
    border-radius: 5px;
    border: none;
    font-size: 15px;
    color: #fff;
    background: #c8c8c8;
    cursor: pointer;
    
/**/
.anw-create th {
	color: #ebdb4b;
}

/* 1:1 상세 문의 내용 */
.anw-create {
	margin-top: 30px;
	text-align: center;
	margin-left: -10px;
}

.qna-create2 {
	margin-top: 30px;
}
/*1:1 상세 내역 조회 답변 등록일*/
.anw-create td {
	display: flex;
	height: 30px;
	justify-content: flex-start;
	align-items: flex-end;
	font-size: 14px;
}

/* 마진을 적용할 클래스 */
.td-with-margin {
  	margin-top: 12px;
	margin-bottom: 12px;
	margin-right: 10px;
	margin-left: 40px;
}
</style>
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
				<sec:authorize access="hasRole('ROLE_ADMIN')">
				<!-- 답변 1개 이상 달리면 댓글창 안 보이게 -->
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
							    <textarea id="editComment" name="answerContent" style=" position: absolute; border : 1px solid #c8c8c8; background : #f5f5f5; margin-left: -621px; margin-top: -130px; width: 700px; height: 110px;"></textarea>
								<input type="hidden" name="questionId" value="${questions.questionId}" />
								<input type="hidden" name="answerId" value="${answers.answerId}" />
							    <button onclick="submitEdit();" name="" class="editComment">수정하기</button>
								</div>
							</form:form>
						</div>
				<!-- 댓글 작성 -->
					<c:if test="${questions.answerCount <= 0}">
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
							<input type="hidden" name="questionEmail" value="${questions.questionEmail}" />
								<button class="anw-btn-create2" type="submit">댓글작성</button>
							</div>
						</form:form>
					</c:if>
				</sec:authorize>
			</div>
		</div>
		<!-- 사용자 버튼 -->
		<div class="qna-create-btn">
			<form
				action="${pageContext.request.contextPath}/admin/adminQuestionList.do"
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