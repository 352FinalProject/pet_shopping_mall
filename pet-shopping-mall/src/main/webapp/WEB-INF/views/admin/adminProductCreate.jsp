<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
	<main>
		<div class="container-md px-4">
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
				<div class=".container-md px-4 mx-auto">
					<form:form action="${pageContext.request.contextPath}/admin/adminProductCreate.do" 
					    name ="createProductFrm"
					    enctype="multipart/form-data" 
					    method="post" class="mt-4">
					        
					        <!-- 1행 -->
					        <div class="row mb-1">
					          <!-- 1. 상품카테고리 -->
					          <label for="categoryId" class="col-sm-2 col-form-label visually-hidden">상품 카테고리</label>
					          
					          <!-- 2열 -->
					          <div class="col-md-6">
					            <label for="productName" class="form-label">상품명</label>
					          </div>
					        </div>
					        <!-- 2행 -->
					        <div class="row mb-5">
					          <!-- 1열 -->
					          <div class="col-md-6">
					            <select name="categoryId" id="categoryId" class="form-select">
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
					          <!-- 2열 -->
					          <div class="col-md-6">
					            <input type="text" name="productName" id="productName" class="form-control" required>
					          </div>
					        </div>
					        
					        <!-- 3행 -->
					        <div class="row mb-1">
					        	<!-- 1열 -->
					          <div class="col-md-6">
					            <label for="file" class="form-label">썸네일 사진(필수)</label>
					          </div>
					          <!-- 2열 -->
					          <div class="col-md-6">
					        	<label for="productPrice" class="form-label">상품금액</label>
					          </div>
					        </div>
					        <!-- 4행 -->
					        <div class="row mb-5">
								<!-- 1열 -->					        
					        	<div class="col-md-6">
					            	<input type="file" name="thumbnailFile" id="file" class="form-control" multiple>
					        	</div>
					        	<!-- 2열 -->
					        	<div class="col-md-6">
					            	<input type="number" name="productPrice" id="productPrice" class="form-control" value="0" required>
					        	</div>
					        </div>
					        
					        <!-- 5행 -->
					        <div class="row mb-1">
					        	<!-- 1열 -->
					          <div class="col-md-6">
					            <label for="file" class="form-label">제품상세 이미지</label>
					          </div>
					          <!-- 2열 -->
					          <div class="col-md-6">
					          </div>
					        </div>
					        <!-- 6행 -->
					        <div class="row mb-5">
								<!-- 1열 -->					        
					        	<div class="col-md-6">
					            	<input type="file" name="detailFile" id="file" class="form-control" multiple>
					        	</div>
					        	<!-- 2열 -->
					        	<div class="col-md-6">
					        	</div>
					        </div>
					        
					        <!-- 7행 -->
					        <div class="row mb-1">
					        	<!-- 1열 -->
					        	<div class="col-md-6">
					        		<label for="addOptions" class="form-label">옵션</label>
					        	</div>
					        </div>
					        <!-- 6행 -->
					        <div class="row mb-5">
								<!-- 1열 -->					        
					        	<div class="col-md-2">
						        	<input class="btn btn-outline-secondary" id="addOptions" type="button" value="옵션 추가">
					        	</div>
					        </div>
					        
							
							<!-- 기본옵션(default) -->
							<div class="viewOption" id="viewOption" style="display : none;">
								<div class="optionValueDefault" id="optionValueDefault">
							          <div class="row mb-3">
								          <div class="col-md-3">
								            <label for="optionName" class="form-label">옵션명</label>
								            <input type="text" name="productDetail[0].optionName" id="optionName" class="form-control" value="옵션없음">
								          </div>
							            <div class="col-md-3">
							              <label for="optionValue" class="form-label">옵션값</label>
							              <input type="text" name="productDetail[0].optionValue" id="optionValue" class="form-control">
							            </div>
							            <div class="col-md-3">
							              <label for="additionalPrice" class="form-label">옵션추가금</label>
							              <input type="number" name="productDetail[0].additionalPrice" id="additionalPrice" class="form-control" value="0">
							            </div>
							          </div>
								    <div class="row mb-3">
								          <div class="col-md-3">
								            <label for="saleState" class="form-label">판매상태</label>
								          </div>
								          <div class="col-md-3">
								            <select name="productDetail[0].saleState" id="saleState" class="form-select">
								              <option value="0">판매대기</option>
								              <option value="1" selected>판매중</option>
								              <option value="2">품절</option>
								              <option value="3">기타</option>
								            </select>
								          </div>
							        </div>
						        </div>
					        </div>
						        
			        <!-- 옵션추가 위치 -->
		        	<div class="row mb-5" id="optionValueInput"></div>

					<!--상품등록버튼 -->
					<div class="row mb-5">
						<div class="col-md-5 d-flex justify-content-end">
							<button class="btn btn-secondary me-2" type="reset">초기화</button>
					        <button class="btn btn-primary" type="submit">상품등록</button>
						</div>
					</div>
					     </form:form> 
					    </div><!-- container-fluid -->
					  </div><!-- card-body -->
				</div><!-- card -->
			</div>
			
		</div>
	</main>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script>
	// 유효성검사
	const productNameInput = document.getElementById("productName");
	const productPriceInput = document.getElementById("productPrice");
	const hasOptionInputs = document.querySelectorAll("input[name=hasOption]");
	const optionValueInput = document.querySelector("#optionValueInput");
	const viewOption = document.getElementById("viewOption");
	const addOptionBtn = document.querySelector("input[id=addOptions]");
	let optionButtonContainers = document.querySelectorAll("#option-btn-container");
	let deleteOptionBtn = document.querySelectorAll("#option-del-btn");
	console.log("addOptionBtn=",addOptionBtn);
	console.log("optionValueInput=", optionValueInput);
	

	// 상품명 검사 함수
    const validateProductName = () => {
    	let name = productNameInput.value;
    	console.log("name=", name)
    	if(name.length <= 2){
    		productNameInput.style.border = "1px solid red";
    	} else {
    		productNameInput.style.border = "1px solid #5886d3";
    	}
    }
    
	// 상품가격 검사 함수
    const validateProductPrice = () => {
    	let price = productPriceInput.value;
    	console.log("price=", price)
    	if(price < 0){
    		alert("상품가격은 음수가 될 수 없습니다.");
    		productPriceInput.value =0;
    	}
    	
    }

    let optionCnt = 1;
    // 옵션추가 함수
    const addOptions = () => {
    	
    	const newOption = `
    	<div class="addedOption" id="addedOption\${optionCnt}">
    		<!-- 1행 -->
			<div class="row mb-3">
				<div class="col-md-3">
					<label for="optionName" class="form-label">옵션명</label>
					<input type="text" name="productDetail[\${optionCnt}].optionName" id="optionName" class="form-control">
				</div>
		        <div class="col-md-3">
		              <label for="optionValue" class="form-label">옵션값</label>
		              <input type="text" name="productDetail[\${optionCnt}].optionValue" id="optionValue" class="form-control">
		        </div>
		        <div class="col-md-3">
		              <label for="additionalPrice" class="form-label">옵션추가금</label>
		              <input type="number" name="productDetail[\${optionCnt}].additionalPrice" id="additionalPrice" class="form-control" value="0">
		        </div>
				<!-- 옵션삭제 버튼 -->
				<div class="col-md-3 d-flex justify-content-end" id="option-btn-container">
	        		<button type="button" class="btn btn-secondary" id="option-del-btn" onclick="delOptions(\${optionCnt})">옵션삭제</button>
				</div>
			      <!-- 기본으로 판매중 -->
				  <div style="display : none;">
				  	<input type="number" name="productDetail[\${optionCnt}].saleState" id="saleState" value="1">
				  </div>
		    </div>
		</div>
    	`;
    	
        optionValueInput.insertAdjacentHTML("beforeend", newOption);
    	optionCnt += 1;

    };
    
    // 옵션삭제 함수
    const delOptions = (optionCnt) => {
        console.log("optionCnt=",optionCnt);
    	const optionToRemove = document.getElementById(`addedOption\${optionCnt}`);
        console.log(optionToRemove);
    	optionToRemove.remove();
    	
    }
    
    productNameInput.addEventListener("input", validateProductName);
    productPriceInput.addEventListener("input", validateProductPrice);
    addOptionBtn.addEventListener("click", addOptions);
	
	// 파일추가 
	document.querySelectorAll("[id=file]").forEach((input) => {
		input.onchange = (e) => {
			const files = e.target.files;
			console.log("files=", files);
			if(files[0]) {
				console.log("파일선택됨");
			}
			else {
				console.log("파일선택 안됨");
			}
		}
	});
	</script>
	<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>