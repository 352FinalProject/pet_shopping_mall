<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 상품등록폼 (수경) --%>
<section class="common-section" id="#">
	<div class="common-title">상품 등록</div>
	<div class="common-container">
		<div class="common-div">
			<form:form 
				action="${pageContext.request.contextPath}/product/addProduct.do" 
				enctype="multipart/form-data" 
				method="post">
				
				<div class="qna-create">
					<div class="input-container">
						<table>
						<tr>
							<th>상품 카테고리</th>
								<td class="productCategory"><select name="productCategory">
										<option value="-선택-">-선택-</option>
										<option value="사료">사료</option>
										<option value="간식"">간식</option>
										<option value="패션용품">패션용품</option>
										<option value="산책용품">산책용품</option>
										<option value="산책용품">산책용품</option>
										<option value="위생용품">위생용품</option>
										<option value="고양이">고양이</option>
										<option value="기타용품">기타용품</option>
									</select></td>
							</tr>
							<tr>
								<th>상품명</th>
								<td><input type="text" name="ProductName" id="ProductName"
									value="" required /></td>
							</tr>
							<tr>
								<th>상품금액</th>
								<td><input type="number" name="productPrice" id="productPrice"
									required></td>
							</tr>
							<tr>
								<th>썸네일(대표) 사진</th>
								<td><label for="file">
								</label> <input type="file" name="upFile" id="file"></td>
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
document.querySelectorAll("[name=file]").forEach((input) => {
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