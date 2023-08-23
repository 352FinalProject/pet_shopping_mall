<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
<main>
<div class="productInfo-container">
	<!-- 상품기본 정보 -->
	<div class="product-container">
		<!-- 상품카테고리 정보 -->
		<div class="product-category-info">
			<div class="row mb-3">
				<div class="col">
				  <label for="categoryId" class="col-sm-6">상품 카테고리</label>
				</div>
				  <div class="col">
		              <select name="categoryId" id="categoryId" class="form-select form-control ">
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
		</div>
		<!-- 상품이름 정보 -->
		<div class="product-name-info">
			<div class="row mb-3">
		      	<div class="col">
		            <label for="productName" class="form-label">제품 이름</label>
		      	</div>
		      	<div class="col">
		            <input type="text" name="productName" id="productName" class="form-control" value="${product.productName}" required>
		      	</div>
	    	</div> 
		</div>
		
		<!-- 가격 정보 -->
		<div class="product-price-info">
			<div class="row mb-3">
				<div class="col">
		            <label for="productPrice" class="form-label">상품금액</label>		
				</div>
				<div class="col">
		            <input type="number" name="productPrice" id="productPrice" class="form-control" value="${product.productPrice}" required>
				</div>
			</div>
		</div>
		<!-- 상품사진 -->
		<div class="product-attachment-info">
			<div class="row mb-3">
		      	<div class="col">
		            <label for="file" class="form-label">제품 사진</label>
		      	</div>
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
		</div>
		<div class="col-md-6">
        	<button type="button" class="btn btn-secondary" onclick="updateProduct();">상품수정</button>
        	<button type="button" class="btn btn-danger" onclick="deleteProduct(${product.productId})">삭제</button>
        </div>
		
	</div>
	
	<!-- 상품옵션 정보 -->
	<c:forEach items="${productDetails}" var="productDetail" varStatus="vs">
	    <div class="productDetail-container-${productDetail.productDetailId}">
	        <div class="row mb-3">
	            <div class="col">
	                <label for="optionName_${productDetail.productDetailId}" class="form-label">옵션명</label>
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
	                <input type="number" name="additionalPrice" id="additionalPrice_${productDetail.productDetailId}" class="form-control" value="0">
	            </div>
	        </div>
	        <div class="row mb-3">
	            <div class="col">
	                <label for="saleState_${productDetail.productDetailId}" class="form-label">판매상태</label>
	            </div>
	            <div class="col">
	                <select name="saleState" id="saleState_${productDetail.productDetailId}" class="form-select">
	                    <option value="0">판매대기</option>
	                    <option value="1">판매중</option>
	                    <option value="2">품절</option>
	                    <option value="3">기타</option>
	                </select>
	            </div>
	        </div>
	        <div class="col-md-6">
	            <button type="button" class="btn btn-secondary" onclick="updateProductOption(${productDetail.productDetailId});">옵션수정</button>
	            <button type="button" class="btn btn-danger" onclick="deleteProductOption(${productDetail.productDetailId});">삭제</button>
	        </div>
	    </div>
	</c:forEach> 	
	
</div>
      <div class="d-flex justify-content-end">
        <button class="btn btn-secondary me-2" type="reset">초기화</button>
      </div>

</main>

<script>
//상품 업데이트 함수
const updateProduct = () => {
    const productId = '${product.productId}'; // 상품 ID
    const productName = document.getElementById('productName').value; // 상품명 입력란의 값
    const productPrice = document.getElementById('productPrice').value; // 상품금액 입력란의 값
    const categoryId = document.getElementById('categoryId').value; // 카테고리 선택값

    const requestData = {
        productId: productId,
        productName: productName,
        productPrice: productPrice,
        categoryId: categoryId,
        imgageId : '${product.imageId}'
        // 여기에 다른 필드들도 추가하면 됩니다.
    };

    // Ajax 요청
    $.ajax({
        url: '${pageContext.request.contextPath}/admin/adminProductUpdate.do?id=' + productId,
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(requestData),
        success: function(response) {
            if (response.code === 200) {
                alert('상품이 성공적으로 업데이트되었습니다.');
                // 업데이트된 내용을 화면에 반영하거나 다른 작업을 수행할 수 있습니다.
            } else {
                alert('상품 업데이트 실패! 관리자에게 문의하세요.');
            }
        },
        error: function() {
            alert('상품 업데이트 요청 실패! 서버 오류가 발생했습니다.');
        }
    });
};

// 상품 삭제 
const deleteProduct = (productId) => {
    if (confirm('정말로 이 상품을 삭제하시겠습니까?')) {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/adminProductDelete.do?id=' + productId,
            type: 'POST',
            dataType: 'json',
            success: function(response) {
                if (response.code === 200) {
                    alert('상품이 성공적으로 삭제되었습니다.');
                    // Refresh the page or update the UI as needed
                } else {
                    alert('상품 삭제 실패! 관리자에게 문의하세요.');
                }
            },
            error: function() {
                alert('상품 삭제 요청 실패! 서버 오류가 발생했습니다.');
            }
        });
    }
};



//상품 옵션 업데이트 함수
const updateProductOption = (productDetailId) => {
	console.log(productDetailId);
    const optionName = document.getElementById(`optionName_`+${productDetailId}).value;
    const optionValue = document.getElementById(`optionValue_${productDetailId}`).value;
    const additionalPrice = document.getElementById(`additionalPrice_${productDetailId}`).value;
    const saleState = document.getElementById(`saleState_${productDetailId}`).value;

    const requestData = {
        productDetailId: productDetailId,
        optionName: optionName,
        optionValue: optionValue,
        additionalPrice: additionalPrice,
        saleState: saleState
        // 여기에 다른 필드들도 추가하면 됩니다.
    };

    // Ajax 요청
    $.ajax({
        url: '${pageContext.request.contextPath}/admin/adminProductDetailUpdate.do?id=' + productDetailId,
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(requestData),
        success: function(response) {
            if (response.code === 200) {
                alert('상품 옵션이 성공적으로 업데이트되었습니다.');
                // 업데이트된 내용을 화면에 반영하거나 다른 작업을 수행할 수 있습니다.
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
    if (confirm('정말로 이 옵션을 삭제하시겠습니까?')) {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/adminProductOptionDelete.do?id=' + productDetailId,
            type: 'POST',
            dataType: 'json',
            success: function(response) {
                if (response.code === 200) {
                    alert('옵션이 성공적으로 삭제되었습니다.');
                    // Refresh the page or update the UI as needed
                } else {
                    alert('옵션 삭제 실패! 관리자에게 문의하세요.');
                }
            },
            error: function() {
                alert('옵션 삭제 요청 실패! 서버 오류가 발생했습니다.');
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
<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>