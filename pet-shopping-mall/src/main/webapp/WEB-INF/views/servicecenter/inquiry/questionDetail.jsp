<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%-- 1:1 문의 작성 (예라) --%>
<section class="common-section" id="#">
	<div class="common-title">1:1 문의 상세 내역</div>
	<div class="common-container">
		<div class="common-div">
			<div class="qna-create">
				<div class="input-container">
					<table>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="memberId" id="memberId"
								value="${questions.memberId}" required readonly /></td>
						</tr>
						<tr>
							<th>사진첨부</th>
							<td><label for="file">
									<div class="btn-upload">파일 첨부</div>
							</label> <input type="file" name="file" id="file"></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" name="title" id="title" readonly
								value="${questions.title}" required></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea name="qna-content" id="content" rows="10" cols="59" readonly style=" resize: none;">
								${questions.content}</textarea></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 내용 섹션 -->
		<div class="content-container">
			<div class="anw-create">
				<table>
					<tr>
						<th>A</th>
						<td><textarea name="content" id="content" readonly
								style="height: 160px; resize: none;">${answers.content}</textarea></td>
						<td class="anw-regdate">
							<br/>
							<fmt:parseDate value="${answers.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate" /> 답변 등록일
							<fmt:formatDate value="${regDate}" pattern="yy/MM/dd" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="qna-create-btn">
			<form action="${pageContext.request.contextPath}/servicecenter/inquiry/questionList.do"
				class="form-inline">
			        <button class="qna-btn-reset" type="submit">목록</button>
			</form>
			        <button class="qna-btn-reset" type="submit">삭제하기</button>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />