<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
<main>
  <div class="container-fluid px-4">
    <form:form action="${pageContext.request.contextPath}/admin/adminProductDetailCreate.do" enctype="multipart/form-data" method="post" class="mt-4">

            <label for="categoryId" class="form-label">상품 카테고리</label>
            <select name="categoryId" id="categoryId" class="form-select">
              <option value="-선택-">-선택-</option>
              <c:if test="${empty categories}">
                <option value="1">카테고리가 없습니다. 카테고리를 추가해주세요</option>
              </c:if>
              <c:if test="${not empty categories}">
                <c:forEach items="${categories}" var="category" varStatus="vs">
                  <option value="${category.categoryId}">${category.categoryName}</option>
                </c:forEach>
              </c:if>
            </select>
          <div class="col-md-6">
            <label for="ProductName" class="form-label">상품명</label>
            <input type="text" name="ProductName" id="ProductName" class="form-control" value="${product.productName}" required>
          </div>
          <div class="col-md-6">
            <label for="productPrice" class="form-label">상품금액</label>
            <input type="number" name="productPrice" id="productPrice" class="form-control" value="${product.productPrice}" required>
          </div>
	      <c:forEach items="${productDetails}" var="productDetail" varStatus="vs">
	          <div class="col-md-6">
	            <label for="optionName" class="form-label">옵션명</label>
	            <input type="text" name="optionName" id="optionName" class="form-control" value="${productDetail.optionName}">
	          </div>
            <div class="col-md-6">
              <label for="optionValue" class="form-label">옵션값</label>
              <input type="text" name="optionValue" id="optionValue" class="form-control" value="${productDetail.optionValue}">
            </div>
            <div class="col-md-6">
              <label class="form-label">추가</label>
              <button type="button" class="btn btn-secondary" onclick="addOptionValue()">추가</button>
            </div>
            <div class="col-md-6">
              <label for="additionalPrice" class="form-label">옵션추가금</label>
              <input type="number" name="additionalPrice" id="additionalPrice" class="form-control" value="0">
            </div>
          <div class="col-md-6">
            <label for="saleState" class="form-label">판매상태</label>
            <select name="saleState" id="saleState" class="form-select">
              <option value="0">판매대기</option>
              <option value="1">판매중</option>
              <option value="2">품절</option>
              <option value="3">기타</option>
            </select>
          </div>
	      
	      </c:forEach>    
	          

        
        <div class="row">
          <div class="col-md-6">
            <label for="file" class="form-label">제품 사진</label>
            <input type="file" name="upFile" id="file" class="form-control">
          </div>
        </div>
      </div>
      <div class="d-flex justify-content-end">
        <button class="btn btn-secondary me-2" type="reset">초기화</button>
        <button class="btn btn-primary" type="submit">상품등록</button>
      </div>

    </form:form>
  </div>
</main>

<script>
  function addOptionValue() {
    const optionValueInput = document.getElementById("optionValue");
    const additionalPriceInput = document.getElementById("additionalPrice");
    const newRow = document.createElement("div");
    newRow.className = "row mt-2";
    newRow.innerHTML = `
      <div class="col-md-6">
        <input type="text" name="optionValue" class="form-control">
      </div>
      <div class="col-md-6">
        <input type="number" name="additionalPrice" class="form-control" value="0">
      </div>
    `;
    optionValueInput.parentElement.insertBefore(newRow, optionValueInput.nextElementSibling);
  }
</script>




<script>
const optionValueInput = document.querySelectorAll(".optionValueInput");
console.log(optionValueInput);

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
<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>