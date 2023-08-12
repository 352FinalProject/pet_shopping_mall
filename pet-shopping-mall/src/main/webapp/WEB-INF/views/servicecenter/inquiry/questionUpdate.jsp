<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 1:1 문의 수정 (예라) --%>
<section class="common-section" id="#">
	<div class="common-title">1:1 문의 수정</div>
	<div class="common-container">
		<div class="common-div">
			<form:form name= "questionUpdateFrm" action="${pageContext.request.contextPath}/servicecenter/inquiry/questionUpdate.do" method="post">
				<div class="qna-create">
					<div class="input-container">
						<table>
							<tr>
								<th>아이디</th>
								<td><input type="text" name="questionMemberId" id="questionMemberId"
									value="${questions.questionMemberId}" required /></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="email" name="questionEmail" id="questionEmail" value="${questions.questionEmail}"
									required></td>
							</tr>
							<tr>
								<th>카테고리</th>
								<td><input type="text" name="questionCategory" id="questionCategory" value="${questions.questionCategory}"
									required></td>
							</tr>
							<tr>
								<th>사진첨부</th>
								<td><label for="file">
								</label> <input type="file" name="upFile" id="file"></td>
							</tr>
							<tr>
								<th>제목</th>
								<td><input type="text" name="questionTitle" id="questionTitle" value="${questions.questionTitle}"
									required></td>
							</tr>
						</table>
					</div>
				</div>
			    <!-- 내용 섹션 -->
			    <div class="content-container">
			        <div class="qna-create">
			            <table>
			                <tr>
			                    <th></th>
			                    <td>
			                        <textarea name="questionContent" rows="4" cols="50" placeholder="상세 내용 (필수)" required>${questions.questionContent}</textarea>
			                    </td>
			                </tr>
			            </table>
			        </div>
			    </div>
			    <div class="qna-create-btn">
			        <button class="qna-btn-reset" type="reset">초기화</button>
			        <input type="hidden" name="questionId" value="${questions.questionId}">
			        <button class="qna-btn-create" type="submit">수정하기</button>
			    </div>
		    </div>
		</div>
	</form:form>
</section>
<script>
</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />