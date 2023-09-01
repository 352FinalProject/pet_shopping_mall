<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">상품 조회</h1>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/admin/admin.do">관리자 홈</a></li>
			</ol>
			<div class="card mb-4">
				<div class="admin-product-search-container">
				<form:form 
			    	method="GET" 
			    	name="adminProductSearch"
			    	action="${pageContext.request.contextPath}/admin/adminProductSearch.do">
			        
		        	<label for="searchKeyword">검색어:</label> 
		        	<input type="text" id="searchKeyword" name="searchKeyword" placeholder="상품명"> 
			        <br>
			        <button type="submit">검색</button>
			        
			    </form:form>

				</div><!-- admin-product-search-container -->
			</div>


			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-table me-1"></i> 기본상품목록
					<input type="button" value="상품등록" id="btn-add"/>
				</div>
				<div class="card-body">
					<table id="datatablesSimple">
						<thead>
							<th>상품아이디</th>
							<th>썸네일 이미지</th>
							<th>상품명</th>
							<th>카테고리</th>
							<th>상품가격</th>
							<th>옵션</th>
							<th>옵션추가금</th>
						</thead>
						<tbody>

							<c:if test="${empty productInfos}">
								<td colspan="5">등록된 상품이 없습니다.</td>
							</c:if>
							<c:if test="${not empty productInfos}">
								<c:forEach items="${productInfos}" var="productInfo" varStatus="vs">
									<tr>
										<%-- <c:if test="${not empty productInfo.productDetails}"></c:if> --%>
										<td>${productInfo.productId}</td>
										<td>
											<c:if test="${empty productInfo.attachments}">
												이미지없음
											</c:if>
 											<c:if test="${not empty productInfo.attachments}">
 											<c:forEach items="${productInfo.attachments}" var="attachment" varStatus="vs">
 												<!-- 썸네일이미지만 출력 -->
												<c:if test="${attachment.thumbnail eq 'Y'}">
												<img style="width: 100px; height: 100px; margin-right: 10px;" alt="상품이미지" 
			                                        class="product-img"
			                                        src="${pageContext.request.contextPath}/resources/upload/product/${attachment.imageRenamedFilename}">
												</c:if>
 											</c:forEach>
											</c:if>
										</td>
										<td>
											<a href="${pageContext.request.contextPath}/admin/adminProductUpdate.do?productId=${productInfo.product.productId}">${productInfo.product.productName}</a>
										</td>
										<td>${productInfo.productCategory.categoryName}</td>
										<td>${productInfo.product.productPrice}</td>
										<td>
											<c:forEach  items="${productInfo.productDetails}" var="productDetail" varStatus="pvs">
												<c:if test="${empty productDetail.optionName || ''}">
													<p>옵션비어있음</p>
												</c:if>
												<c:if test="${not empty productDetail.optionName}">
													<p>[${productDetail.optionName}] ${productDetail.optionValue}</p>
												</c:if>
											</c:forEach>
										</td>
										<td>
											<c:forEach  items="${productInfo.productDetails}" var="productDetail" varStatus="pvs">
												<p>${productDetail.additionalPrice}</p>
											</c:forEach>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
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
	
	
/* 	adminProductSearch.onsubmit = (e) => {
		const {searchKeyword, searchCategory, saleState} = e.target;
		console.log(searchKeyword.value);
		console.log(searchCategory.value);
		console.log(saleState);
	    const searchKeyword = searchKeyword.value; 
	    const searchCategory = searchCategory.value; 
	    
	    const requestData = {
	    	searchKeyword: searchKeyword,
	    	searchCategory: searchCategory
	    };
		if (searchKeyword.length > 0){
		    // Ajax 요청
		    $.ajax({
		        url: '${pageContext.request.contextPath}/admin/adminProductSearch.do',
		        type: 'GET',
		        dataType: 'json',
		        contentType: 'application/json',
		        data: JSON.stringify(requestData)
		    }).done(function(data) {
		        updateQuestionList(data.productInfos);
		      });
		}
		e.preventDefault();
	} */
	
	
	const selectAllStatus = () => {
		const checkAll = document.getElementById('saleStatusAll');
        const productStatusCheckboxes = document.getElementsByName('saleState');
		console.log(checkAll);
		if(checkAll.checked == true){
	        productStatusCheckboxes.forEach((checkbox) => {
	        	checkbox.checked = true;
	        });			
		} else {
	        productStatusCheckboxes.forEach((checkbox) => {
	        	checkbox.checked = false;
	        });						
		}
    };
    
	document.querySelector("#btn-add").onclick = () => {
		location.href = '${pageContext.request.contextPath}/admin/adminProductCreate.do';
	};
	</script>
	<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>