<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">상품 수정</h1>
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
					    <%-- <form:form action="${pageContext.request.contextPath}/admin/adminProductCreate.do" enctype="multipart/form-data" method="post" class="mt-4"> --%>
					
					      <div class="mb-3">
					        
					        <div class="row mb-3">
					          <div class="col-md-3">
					            <label for="categoryId" class="form-label">상품 카테고리</label>
					          </div>
					          <div class="col-md-3">
					              <select name="categoryId" id="categoryId" class="form-select form-control ">
					              <option value="-선택-">-선택-</option>
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
					        <div class="row mb-3">
					          <div class="col-md-3">
					            <label for="ProductName" class="form-label">상품명</label>
					            <input type="text" name="productName" id="productName" value="${product.productName}" class="form-control" required>
					          </div>
					          <div class="col-md-3">
					            <label for="productPrice" class="form-label">상품금액</label>
					            <input type="number" name="productPrice" id="productPrice" value="${product.productPrice}" class="form-control" required>
					          </div>
					        </div>
					        
							<!-- 					        
					        <div class="row mb-5">
					          <div class="col-md-3">
					            <label for="file" class="form-label">제품 사진</label>
					          </div>
					          <div class="col-md-3">
							      	<c:if test="${not empty productInfo.attachments}">
								      	<c:forEach items="${productInfo.attachments}" var="attach" varStatus="vs">
								      		${vs }<img style="width: 100px; height: 100px; margin-right: 10px;" alt="상품이미지" 
						                        class="product-img"
						                        src="${pageContext.request.contextPath}/resources/upload/product/${attach[vs].imageRenamedFilename}">
								      	</c:forEach>
							      	</c:if>
							      	<c:if test="${empty productInfo.attachments}">
								      	<div class="col">
								            <input type="file" name="upFile" id="file" class="form-control">
								      	</div>
							      	</c:if>
					          </div>
					           -->
							<div class="col-md-6">
					            <button type="button" class="btn btn-secondary" onclick='updateProduct();'>상품 수정</button>
					            <button type="button" class="btn btn-danger" onclick="deleteProduct();">상품 삭제</button>
					        </div>
					          
					          
					        </div>
					        
					        
					        
	<!-- 상품옵션 정보 -->
	<c:forEach items="${productDetails}" var="productDetail" varStatus="vs">
	    <div class="productDetail-container-${productDetail.productDetailId}">
	        <div class="row mb-3">
	            <div class="col">
	                <label for="optionName_${productDetail.productDetailId}" class="form-label">옵션명 ${vs.count}</label>
	            </div>
	            <div class="col">
	                <input type="text" name="optionName" id="optionName_${productDetail.productDetailId}" class="form-control" value="${productDetail.optionName}">
	            </div>
	        </div>
	        <div class="row mb-3">
	            <div class="col">
	                <label for="optionValue_${productDetail.productDetailId}" class="form-label">옵션값</label>
	            </div>
	            <div class="col">
	                <input type="text" name="optionValue" id="optionValue_${productDetail.productDetailId}" class="form-control" value="${productDetail.optionValue}">
	            </div>
	        </div>
	        <div class="row mb-3">
	            <div class="col">
	                <label for="additionalPrice_${productDetail.productDetailId}" class="form-label">옵션추가금</label>
	            </div>
	            <div class="col">
	                <input type="number" name="additionalPrice" id="additionalPrice_${productDetail.productDetailId}" class="form-control" value="${productDetail.additionalPrice}">
	            </div>
	        </div>
	        <div class="row mb-3">
	            <div class="col">
	                <label for="saleState_${productDetail.productDetailId}" class="form-label">판매상태</label>
	            </div>
	            <div class="col">
	                <select name="saleState" id="saleState_${productDetail.productDetailId}" class="form-select">
	                    <option value="0" ${productDetail.saleState eq 0 ? "selected" : ""} >판매대기</option>
	                    <option value="1" ${productDetail.saleState eq 1 ? "selected" : ""}>판매중</option>
	                    <option value="2" ${productDetail.saleState eq 2 ? "selected" : ""}>품절</option>
	                    <option value="3" ${productDetail.saleState eq 3 ? "selected" : ""}>기타</option>
	                </select>
	            </div>
	        </div>
	        <div class="col-md-6">
	            <button type="button" class="btn btn-secondary" onclick='updateProductOption(${productDetail.productDetailId});'>옵션${vs.count} 수정</button>
	            <button type="button" class="btn btn-danger" onclick="deleteProductOption(${productDetail.productDetailId});">옵션${vs.count} 삭제</button>
	        </div>
	    </div>
	</c:forEach> 
					      
					    <%-- </form:form> --%>
					  </div>
				</div>
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

//상품 업데이트(수경)
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
	console.log(requestData);
    // Ajax 요청
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

// 상품 삭제(수경)
const deleteProduct = () => {
    const requestData = {
            productId: '${product.productId}'
        };
    console.log(requestData);
    
	if (confirm('정말로 이 상품을 삭제하시겠습니까?')) {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/adminProductDelete.do',
            type: 'POST',
            dataType: 'json',
            data: JSON.stringify(requestData),
            contentType: 'application/json',
            success: function(response) {
            	console.log(response);
                alert('삭제 성공했습니다');
                window.location.href = '${pageContext.request.contextPath}/admin/adminProductList.do';
            },
            error: function(xhr, textStatus, errorThrown) {
                alert('${product.productName}상품 삭제 실패했습니다');
            }
        });
    }
};


//상품 옵션 업데이트 함수
const updateProductOption = (productDetailId) => {
    const optionName = document.getElementById(`optionName_\${productDetailId}`).value;
    const optionValue = document.getElementById(`optionValue_\${productDetailId}`).value;
    const additionalPrice = document.getElementById(`additionalPrice_\${productDetailId}`).value;
    const saleState = document.getElementById(`saleState_\${productDetailId}`).value;

    const requestData = {
        productDetailId: `\${productDetailId}`,
        optionName: optionName,
        optionValue: optionValue,
        additionalPrice: additionalPrice,
        saleState: saleState
    };
	console.log(requestData);
    
    // Ajax 요청
    $.ajax({
        url: '${pageContext.request.contextPath}/admin/adminProductDetailUpdate.do',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(requestData),
        success: function(response) {
        	console.log(response);
            if (response == 1) {
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
// 상품옵션 삭제 요청
const deleteProductOption = (productDetailId) => {
    const requestData = {
    	productDetailId: `\${productDetailId}`	
    };
	console.log(requestData);
	if (confirm('정말로 이 옵션을 삭제하시겠습니까?')) {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/adminProductOptionDelete.do',
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(requestData),
            success: function(response) {
                if (response === 1) {
                	const optionDiv = document.querySelector('.productDetail-container-${productDetail.productDetailId}');
                	console.log(response);
                	optionDiv.remove();
                    alert('옵션이 성공적으로 삭제되었습니다.');
                } else {
                    alert('옵션 삭제 실패! 관리자에게 문의하세요.');
                }
            }
        });
    }
};

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