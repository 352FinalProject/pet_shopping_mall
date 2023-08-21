<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 상품등록폼 (수경) --%>
<section class="common-section" id="#">
	<div class="common-title">상품 기본 등록</div>
	<div class="common-container">
		<div class="common-div">
		
			<form:form 
				action="${pageContext.request.contextPath}/admin/adminAddProductOption.do" 
				enctype="multipart/form-data" 
				method="post">
				
				<div class="qna-create">
					<div class="input-container">
						<table>
						<tr>
							<th>상품 카테고리</th>
								<td class="productCategory"><select name="categoryId" id="categoryId">
										<option value="-선택-">-선택-</option>
										<c:if test="${empty categories}">
											<option value="1">카테고리가 없습니다. 카테고리를 추가해주세요</option>
										</c:if>
										<c:if test="${not empty categories}">
											<c:forEach items="${categories}" var="category" varStatus="vs">
												<option value="${category.categoryId}">${category.categoryName}</option>
											</c:forEach>
										</c:if>
									</select></td>
							</tr>
							<tr>
								<th>상품명</th>
								<td><input type="text" name="ProductName" id="ProductName"
									value="" required /></td>
							</tr>
							<tr>
								<th>옵션명</th>
								<td>
									<select name="optionName" id="optionName">
										<option value="">-선택안함-</option>
										<option value="색">색</option>
										<option value="사이즈">사이즈</option>
										<option value="무게">무게</option>
										<option value="기타">기타</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>옵션값</th>
								<td><input type="text" name="optionValue" id="optionValue"></td>
							</tr>
							<tr>
								<th>상품금액</th>
								<td><input type="number" name="productPrice" id="productPrice"
									required></td>
							</tr>
							<tr>
								<th>썸네일(대표) 사진</th>
								<td><label for="file">
								</label> <input type="file" name="upFile" id="file1"></td>
							</tr>
							<tr>
								<th>제품 사진</th>
								<td><label for="file">
								</label> <input type="file" name="upFile" id="file2"></td>
							</tr>
						</table>
					</div>
				</div>
			    <div class="qna-create-btn">
			        <button class="qna-btn-reset" type="reset">초기화</button>
			        <button class="qna-btn-create" type="submit">상품등록</button>
			    </div>
			</form:form>
			
	    </div>
	</div>
</section>
<script>
document.querySelectorAll("[name=upFile]").forEach((input) => {
	input.onchange = (e) => {
		const label = e.target.previousElementSibling;
		const files = e.target.files;
		if(files[0]) {
			label.innerHTML = files[0].name;
		}
		else {
			label.innerHTML = "파일을 선택하세요";
		}
	}
});
</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />