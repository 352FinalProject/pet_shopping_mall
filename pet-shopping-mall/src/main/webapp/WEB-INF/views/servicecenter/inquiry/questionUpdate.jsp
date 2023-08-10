<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 1:1 문의 수정 (예라) --%>
<section class="common-section" id="#">
	<div class="common-title">1:1 문의 수정</div>
	<div class="common-container">
		<div class="common-div">
			<form name= "questionUpdateFrm" action="${pageContext.request.contextPath}/servicecenter/inquiry/questionUpdate.do" method="post">
				<div class="qna-create">
					<div class="input-container">
						<table>
							<tr>
								<th>아이디</th>
								<td><input type="text" name="memberId" id="memberId" value="${questions.memberId}" required /></td>
							</tr>
							<tr>
								<th>사진첨부</th>
								<td><label for="file">
										<div class="btn-upload">파일 첨부</div>
								</label> <input type="file" name="file" id="file"></td>
							</tr>
							<tr>
								<th>상품코드</th>
								<td><input type="text" name="productId" id="productId" value="${questions.productId}" required /></td>
							</tr>
							<tr>
								<th>제목</th>
								<td><input type="text" name="title" id="title" value="${questions.title}" required /></td>
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
			                        <textarea name="content" rows="4" cols="50" placeholder="상세 내용 (필수)" required>${questions.content}</textarea>
			                    </td>
			                </tr>
			            </table>
			        </div>
			    </div>
			    <div class="qna-create-btn">
			        <button class="qna-btn-reset" type="reset">초기화</button>
			        <input type="hidden" name="id" value="${questions.id}">
			        <button class="qna-btn-create" type="submit">수정하기</button>
			    </div>
		    </div>
		</div>
	</form>
</section>
<script>
</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />