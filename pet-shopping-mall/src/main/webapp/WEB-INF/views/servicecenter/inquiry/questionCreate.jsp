<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%-- 1:1 문의 작성 (예라) --%>
<section class="common-section" id="#">
	<div class="common-title">1:1 문의 작성</div>
	<div class="common-container">
		<div class="common-div">
			<form action="${pageContext.request.contextPath}/servicecenter/inquiry/questionCreate.do" method="post">
				<div class="qna-create">
					<div class="input-container">
						<table>
							<tr>
								<th>아이디</th>
								<td><input type="text" name="memberId" id="memberId"
									value="" required /></td>
							</tr>
							<tr>
								<th>사진첨부</th>
								<td><label for="file">
										<div class="btn-upload">파일 첨부</div>
								</label> <input type="file" name="file" id="file"></td>
							</tr>
							<tr>
								<th>상품코드</th>
								<td><input type="text" name="productId" id="productId"
									required></td>
							</tr>
							<tr>
								<th>제목</th>
								<td><input type="text" name="title" id="title"
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
			                        <textarea name="content" rows="4" cols="50" placeholder="상세 내용 (필수)" required></textarea>
			                    </td>
			                </tr>
			            </table>
			        </div>
			    </div>
			    </form>
			    <div class="qna-create-btn">
				    <form action="${pageContext.request.contextPath}/servicecenter/inquiry/questionList.do"
						class="form-inline">
				        <button class="qna-btn-reset" type="submit">목록</button>
				    </form>
			        	<button class="qna-btn-create" type="submit">작성하기</button>
			    </div>
		    </div>
		</div>
</section>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />