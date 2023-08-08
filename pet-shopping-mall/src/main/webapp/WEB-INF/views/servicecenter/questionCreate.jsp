<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 1:1 문의 작성 (예라) --%>
<section class="common-section" id="#">
	<div class="common-title">1:1 문의 작성</div>
	<div class="common-container">
		<div class="common-div">
			<div class="qna-create">
				<table>
					<tr>
						<th>이름<span>*</span></th>
						<td><input type="text" name="memberId" id="memberId" value=""
							required /></td>
					</tr>
					<tr>
						<th>핸드폰번호</th>
						<td><input type='tel' name='phone1' />-
        					<input type='tel' name='phone2' />-
        					<input type='tel' name='phone3' />
        				</td>
					</tr>
					<tr>
						<th>사진첨부</th>
						<td>
							<div class="custom-file">
								<input type="file" class="custom-file-input" name="upFile"
									id="upFile1" multiple>
							</div>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="title" id="title" value=""
							required></td>
					</tr>
					<tr>
						<td><input type="text" name="title" id="title" value=""
							required>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />