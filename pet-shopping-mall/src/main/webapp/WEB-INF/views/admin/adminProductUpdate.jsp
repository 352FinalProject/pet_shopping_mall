<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<ol class="breadcrumb mb-4"></ol>


			<div class="card mb-4 mt-4">
				<div class="card-header">
					등록 상품
				</div>
				
				<div class="card-body">
					<div class="container-md px-4">

			        <!-- 1행 : 카테고리 수정 -->
			        <div class="row g-12 mb-3 align-items-center">
						<div class="col-sm-3">
							<label for="categoryId" class="col-form-label">상품 카테고리</label>
						</div>
						<div class="col-auto">
			            <select name="categoryId" id="categoryId" class="form-select">
			              	<c:if test="${empty categories}">
			                	<option value="1">카테고리가 없습니다. 카테고리를 추가해주세요</option>
			              	</c:if>
			              	<c:if test="${not empty categories}">
			                <c:forEach items="${categories}" var="category" varStatus="vs">
			                  	<option value="${category.categoryId}" ${category.categoryId eq product.categoryId ? "selected" : ""} >${category.categoryName}</option>
			                </c:forEach>
			              	</c:if>
			            </select>
			          	</div>
					</div>
			        
			        <!-- 2행: 상품명 입력 -->
			        <div class="row mb-3 align-items-center">
				        <div class="col-sm-3">
							<label for="productName" class="form-label">상품명</label>
						</div>
						<div class="col-auto">
							<input type="text" name="productName" id="productName"  value="${product.productName}" class="form-control" required>
			          	</div>
			        </div>

			        <!-- 3행: 가격 입력 -->
			        <div class="row mb-4 align-items-center">
				        <div class="col-sm-3">
							<label for="productPrice" class="form-label">상품금액</label>
						</div>
						<div class="col-auto">
							<input type="number" name="productPrice" id="productPrice" class="form-control" value="${product.productPrice}" required>
			          	</div>
			        </div>
			        
					<!--상품수정 버튼 -->
					<div class="row mb-4 align-items-center justify-content-around">
						<div class="col-md-4 align-self-center">
							<button type="button" class="btn btn-secondary" onclick='updateProduct();'>상품 수정</button>
					        <button type="button" class="btn btn-danger" onclick="deleteProduct();">상품 삭제</button>
						</div>
					</div>

				    <!-- 옵션추가 버튼 -->
				    <div class="row mb-4">
						<div class="col-md-4">
							<button type="button" class="btn btn-secondary" onclick="addOption();">옵션 추가</button>
						</div>
					</div>					
							
					<!-- 상품옵션 정보 -->
					<c:forEach items="${productDetails}" var="productDetail" varStatus="vs">
						<c:if test="${not empty productDetail.optionName}">
							<!-- 옵션명이 옵션없음이면 보여주지 않음 -->
							<c:if test="${productDetail.optionName eq '옵션없음'}"></c:if>
							<!-- 그 외 -->
							<c:if test="${productDetail.optionName ne '옵션없음'}">
								<!-- 옵션정보 -->
						    	<div class="productDetail-container-${productDetail.productDetailId}">
									<div class="addedOption row mb-3 align-items-end" id="addedOption\${optionCnt}">
										<div class="col-sm-3">
											<label for="optionName" class="form-label">옵션명</label>
											<input type="text" name="optionName" id="optionName_${productDetail.productDetailId}" class="form-control" value="${productDetail.optionName}" required>
										</div>
								        <div class="col-sm-3">
								              <label for="optionValue" class="form-label">옵션값</label>
								              <input type="text" name="optionValue" id="optionValue_${productDetail.productDetailId}" class="form-control" value="${productDetail.optionValue}">
								        </div>
								        <div class="col-sm-3">
								              <label for="additionalPrice" class="form-label">옵션추가금</label>
								              <input type="number" name="additionalPrice" id="additionalPrice_${productDetail.productDetailId}" class="form-control" value="${productDetail.additionalPrice}">
								        </div>
										<!-- 옵션 수정, 삭제 버튼 -->
										<div class="col-sm-3" id="option-btn-container">
											<button type="button" class="btn btn-secondary" onclick='updateProductOption(${productDetail.productDetailId});'>옵션 수정</button>
							        		<button type="button" class="btn btn-secondary" id="option-del-btn" onclick="deleteProductOption(${productDetail.productDetailId})">옵션 삭제</button>
										</div>
									</div>
								</div>
							</c:if>
						</c:if>
					</c:forEach>
				
					<!-- 옵션추가 공간-->
					<div class="addOptionDiv" id="addOptionDiv"></div>

			        <!-- 3행 : 썸네일 사진-->
			        <div class="row mb-3">
			        	<div class="col-sm-3">
			            	<label for="file" class="form-label">썸네일 사진</label>
			        	</div>
			        	<div class="col-auto">
				        	<!-- 상품이미지가 있다면 -->
					        	<c:if test="${not empty attachments}">
					        		<c:forEach items="${attachments}" var="attachment" varStatus="vs">
					        			<c:if test="${attachment.thumbnail eq 'Y'}">
										<img alt="" 
											src="${pageContext.request.contextPath}/resources/upload/product/${attachment.imageRenamedFilename}"
											width="200px">
					        			</c:if>
					        		</c:forEach>
				        	</c:if>
				        	<!-- 상품이미지가 없다면 -->
					        	<c:if test="${empty attachments}">
					        		이미지가 없습니다.
					            <input type="file" name="upFile" id="file" class="form-control">
				        	</c:if>
			        	</div>
			        </div>
			        
			        <!-- 4행 : 상세사진 -->
			        <div class="row mb-5">
			        	<div class="col-sm-3">
			            	<label for="file" class="form-label">상세 이미지</label>
			        	</div>
			        	<div class="col-auto">
				        	<!-- 상품이미지가 있다면 -->
					        	<c:if test="${not empty attachments}">
					        		<c:forEach items="${attachments}" var="attachment" varStatus="vs">
					        			<c:if test="${attachment.thumbnail eq 'N'}">
										<img alt="" 
											src="${pageContext.request.contextPath}/resources/upload/product/${attachment.imageRenamedFilename}"
											width="200px">
					        			</c:if>
					        		</c:forEach>
				        	</c:if>
				        	<!-- 상품이미지가 없다면 -->
					        <c:if test="${empty attachments}">
					        	이미지가 없습니다.
					            <!-- <input type="file" name="upFile" id="file" class="form-control"> -->
				        	</c:if>
			        	</div>
			        </div>

				</div><!-- card-body -->
			</div>
		</div>
	</main>
	
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>	
<script>
//ajax 요청시 사용할 csrf 글로벌 변수설정
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(function() {
    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
});

/**
 * 상품 업데이트(수경)
 */
const updateProduct = () => {
    const productId = '${product.productId}'; // 상품 ID
    const productName = document.getElementById('productName').value; // 상품명 입력란의 값
    const productPrice = document.getElementById('productPrice').value; // 상품금액 입력란의 값
    const categoryId = document.getElementById('categoryId').value; // 카테고리 선택값
    
    const requestData = {
	    productId: productId,
	    categoryId: categoryId,
	    productName: productName,
	    productPrice: productPrice,
	    categoryId: categoryId,
        imageId : '${product.imageId}'
    };
    
    $.ajax({
        url: '${pageContext.request.contextPath}/admin/adminProductUpdate.do',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(requestData),
        success: function(response) {
        	console.log(response);
          	alert('상품이 성공적으로 업데이트되었습니다.');
        }
    });
};

/**
 * 상품 삭제(수경)
 */
const deleteProduct = () => {
    const requestData = {
            productId: '${product.productId}'
        };
    
	if (confirm('정말로 이 상품을 삭제하시겠습니까?')) {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/adminProductDelete.do',
            type: 'POST',
            dataType: 'json',
            data: JSON.stringify(requestData),
            contentType: 'application/json',
            success: function(response) {
            	console.log(response);
                alert('${product.productName} 삭제 성공했습니다');
                window.location.href = '${pageContext.request.contextPath}/admin/adminProductList.do';
            },
            error: function(xhr, textStatus, errorThrown) {
                alert('${product.productName} 상품 삭제 실패했습니다');
            }
        });
    }
};


/**
 * 상품옵션 업데이트 함수
 */
const updateProductOption = (productDetailId) => {
    const optionName = document.getElementById(`optionName_\${productDetailId}`).value;
    const optionValue = document.getElementById(`optionValue_\${productDetailId}`).value;
    const additionalPrice = document.getElementById(`additionalPrice_\${productDetailId}`).value;

    const requestData = {
        productDetailId: `\${productDetailId}`,
        optionName: optionName,
        optionValue: optionValue,
        additionalPrice: additionalPrice,
    };

    // Ajax 요청
    $.ajax({
        url: '${pageContext.request.contextPath}/admin/adminProductDetailUpdate.do',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(requestData),
        success: function(response) {
            if (response === 1) {
                alert('상품 옵션이 성공적으로 업데이트되었습니다.');
            } else {
                alert('상품 옵션 업데이트 실패! 관리자에게 문의하세요.');
            }
        },
        error: function() {
            alert('상품 옵션 업데이트 요청 실패! 서버 오류가 발생했습니다.');
        }
    });
};

/**
 * 상품옵션 삭제 함수
 */
const deleteProductOption = (productDetailId) => {
    const requestData = {
    	productDetailId: `\${productDetailId}`	
    };

	if (confirm('정말로 이 옵션을 삭제하시겠습니까?')) {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/adminProductOptionDelete.do',
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(requestData),
            success: function(response) {
                if (response === 1) {
                    alert('옵션이 성공적으로 삭제되었습니다.');
                	const optionDiv = document.querySelector(`.productDetail-container-\${productDetailId}`);
                	optionDiv.remove();
                } else {
                    alert('옵션 삭제 실패! 관리자에게 문의하세요.');
                }
            }
        });
    }
};

/**
 * 옵션추가 (페이지 동적처리)
 */
const addOption = () => {
	const addOptionDiv = document.getElementById("addOptionDiv");
	
	const newOption =`
    <form:form 
    	name="optionCreateFrm"
        action="${pageContext.request.contextPath}/admin/adminOptionCreate.do"
        method="POST">
		<!-- 추가옵션 -->
    	<div class="productDetail-container-${productDetail.productDetailId}">
    		<input type="text" name="productId" id="productId" class="form-control" value="${product.productId}" style="display : none;">
	        <div class="row mb-1">
	        	<div class="col-md-3">
	        		<label for="optionName" class="form-label">옵션명</label>
	        	</div>
	        	<div class="col-md-3">
		        	<label for="optionValue" class="form-label">옵션값</label>
	        	</div>
	        	<div class="col-md-3">
		        	<label for="additionalPrice}" class="form-label">옵션추가금</label>
	        	</div>
	        	<div class="col-md-3">
	        	</div>
	        </div>
	        <div class="row mb-4">
	        	<div class="col-md-3">
		        	<input type="text" name="optionName" id="optionName" class="form-control" required>
	        	</div>
	        	<div class="col-md-3">
		        	<input type="text" name="optionValue" id="optionValue" class="form-control">
	        	</div>
	        	<div class="col-md-3">
		        	<input type="number" name="additionalPrice" id="additionalPrice" class="form-control" value="0">
	        	</div>
	        	<div class="col-md-3">
	        	<button type="submit" class="btn btn-secondary">옵션 등록</button>
	        	</div>
	        </div>
		</div>
    </form:form>
	`;
	addOptionDiv.insertAdjacentHTML("beforeend", newOption);
}

/**
 * 폼 제출 시 동작
 */
$(document).on('submit', function(e) {
	// 동적으로 폼을 추가할 때는 일일이 핸들러를 추가해주어야 한다. 그렇게 하기는 번거롭기 때문에 상위 요소에서 접근해서 처리한다.
	const createFrm = e.target.matches('[name=optionCreateFrm]');

	if(e.target.matches('[name=optionCreateFrm]')) {
		  event.preventDefault(); 
		  
		  const optionData = {
		    productId: $('#productId').val(),
		    optionName: $('#optionName').val(),
		    optionValue: $('#optionValue').val(),
		    additionalPrice: $('#additionalPrice').val(),
		  };
		
		  $.ajax({
		    type: 'POST',
		    url: '${pageContext.request.contextPath}/admin/adminOptionCreate.do',
		    contentType: 'application/json',
		    data: JSON.stringify(optionData),
		    success: function(response) {
		      console.log(response);
		      alert('옵션이 성공적으로 추가되었습니다.');
		      location.reload();
		    },
		    error: function(error) {
		      console.error(error);
		      alert('옵션 추가 중 오류가 발생했습니다.');
		    }
		});
	}
});


// 파일업로드
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

			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; 김대원김대원김대원입니다?</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
	</div>
	<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
	<script	src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/datatables-simple-demo.js"></script>
	
</body>
</html>