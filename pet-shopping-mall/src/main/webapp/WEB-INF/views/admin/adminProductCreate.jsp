<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">상품 등록</h1>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/admin/admin.do">관리자 홈</a></li>
			</ol>

			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-table me-1"></i> 기본상품목록
				</div>
				<div class="card-body">
					  <div class="container-fluid px-4">
					    <form:form action="${pageContext.request.contextPath}/admin/adminProductCreate.do" enctype="multipart/form-data" method="post" class="mt-4">
					
					      <div class="mb-3">
					        
					        <div class="row mb-3">
					          <div class="col-md-3">
					            <label for="categoryId" class="form-label">상품 카테고리</label>
					          </div>
					          <div class="col-md-3">
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
					          </div>
					        </div>
					        <div class="row mb-3">
					          <div class="col-md-3">
					            <label for="ProductName" class="form-label">상품명</label>
					            <input type="text" name="ProductName" id="ProductName" class="form-control" required>
					          </div>
					          <div class="col-md-3">
					            <label for="productPrice" class="form-label">상품금액</label>
					            <input type="number" name="productPrice" id="productPrice" class="form-control" required>
					          </div>
					        </div>
					        <div class="row mb-5">
					          <div class="col-md-3">
					            <label for="file" class="form-label">제품 사진</label>
					          </div>
					          <div class="col-md-3">
					            <input type="file" name="upFile" id="file" class="form-control">
					          </div>
					        </div>
					        
	        	        <div class="noOption" id="noOption">
				          <div class="row mb-3" style="display: none;">
					          <div class="col-md-2">
					            <label for="optionName" class="form-label">옵션명</label>
					            <input type="text" name="productDetail.optionName" id="optionName" class="form-control">
					          </div>
				            <div class="col-md-2">
				              <label for="optionValue" class="form-label">옵션값</label>
				              <input type="text" name="productDetail.optionValue" id="optionValue" class="form-control">
				            </div>
				            <div class="col-md-2">
				              <label for="additionalPrice" class="form-label">옵션추가금</label>
				              <input type="number" name="productDetail.additionalPrice" id="additionalPrice" class="form-control" value="0">
				            </div>
				          </div>
					        <div class="row mb-3">
					          <div class="col-md-1">
					            <label for="saleState" class="form-label">판매상태</label>
					          </div>
					          <div class="col-md-2">
					            <select name="productDetail.saleState" id="saleState" class="form-select">
					              <option value="0">판매대기</option>
					              <option value="1">판매중</option>
					              <option value="2">품절</option>
					              <option value="3">기타</option>
					            </select>
					          </div>
				        </div>
				      </div><!-- noOption -->
					        
					        
					        
					        <!-- 옵션추가 버튼 -->
				        	<div class="row mb-3">
					            <div class="col-md-3">
					              <button type="button" class="btn btn-secondary" onclick="addOptionValue()">옵션추가</button>
					            </div>
					        </div>

							<!-- 옵션추가용 태그 -->
					        <div class="optionValueInput" id="optionValueInput"> </div>
					        
					      <div class="row mb-5">
						      <div class="col-md-5 d-flex justify-content-end">
						        <button class="btn btn-secondary me-2" type="reset">초기화</button>
						        <button class="btn btn-primary" type="submit">상품등록</button>
						      </div>
					      </div>
					      
					    </form:form>
					  </div>
				</div>
			</div>
			
		</div>
	</main>
	<script>
	let optionNumber = 1;
	let optionValueInput = null;
	const addOptionValue = () => {
		$('#noOption').remove();
		
		let optionValueInput = document.getElementById('optionValueInput');
		console.log(optionValueInput);
		
		const optionAddDiv = `
	        <div class="optionValueInput" id="optionValueInput">
          <div class="row mb-3">
	          <div class="col-md-2">
	            <label for="optionName" class="form-label">옵션명 \${optionNumber}</label>
	            <input type="text" name="productDetail[\${optionNumber}].optionName" id="optionName" class="form-control">
	          </div>
            <div class="col-md-2">
              <label for="optionValue" class="form-label">옵션값 \${optionNumber}</label>
              <input type="text" name="productDetail[\${optionNumber}].optionValue" id="optionValue" class="form-control">
            </div>
            <div class="col-md-2">
              <label for="additionalPrice" class="form-label">옵션추가금 \${optionNumber}</label>
              <input type="number" name="productDetail[\${optionNumber}].additionalPrice" id="additionalPrice" class="form-control" value="0">
            </div>
          </div>
	        <div class="row mb-3">
	          <div class="col-md-1">
	            <label for="saleState" class="form-label">판매상태 \${optionNumber}</label>
	          </div>
	          <div class="col-md-2">
	            <select name="productDetail[\${optionNumber}].saleState" id="saleState" class="form-select">
	              <option value="0">판매대기</option>
	              <option value="1">판매중</option>
	              <option value="2">품절</option>
	              <option value="3">기타</option>
	            </select>
	          </div>
        </div>
      </div>	
		`;
		
		if(optionValueInput != null){
		optionValueInput.innerHTML += optionAddDiv;
		optionNumber += 1;			
		}
	}
	
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