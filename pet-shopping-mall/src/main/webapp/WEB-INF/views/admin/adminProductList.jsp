<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h2 class="mt-3">상품 조회</h2>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"></li>
			</ol>
			<div class="card mb-4">
				<!-- 상품검색 -->
				<div class="card-body">
				<div class="admin-product-search-container">
				<form:form 
			    	method="GET" 
			    	name="adminProductSearch"
			    	action="${pageContext.request.contextPath}/admin/adminProductSearch.do">
			        <div class="input-group">
						<input type="text" id="searchKeyword" name="searchKeyword" placeholder="상품명">
						<input type="submit" value="검색" class ="btn btn-secondary">
					</div>
			    </form:form>

				</div><!-- admin-product-search-container -->
			</div>
			</div>


			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-table me-1"></i> 기본상품목록
					<input type="button" value="상품등록" id="btn-add" class="btn btn-secondary"/>
				</div>
				<div class="card-body">
				<!-- 등록된 상품이 없으면 -->
				<c:if test="${empty productInfos}">
					<div>
					등록된 상품이 없습니다.
					</div>
				</c:if>
				<!-- 등록된 상품이 있으면 -->
				<c:if test="${not empty productInfos}">
					<table id="datatablesSimple">
						<thead>
							<th>상품아이디</th>
							<th>썸네일 이미지</th>
							<th>상품명</th>
							<th>카테고리</th>
							<th>상품가격</th>
							<th>옵션</th>
						</thead>
						<tbody>
						<c:forEach items="${productInfos}" var="productInfo" varStatus="vs">
							<tr>
								<td>${productInfo.productId}</td>
								<td>
									<c:if test="${empty productInfo.attachments}">
										<div class="card text-center" style="width: 10rem; height: 10rem;">
											<p class="h4 align-middle">이미지 없음</p>
										</div>
									</c:if>
										<c:if test="${not empty productInfo.attachments}">
										<!-- 썸네일이미지만 출력 -->
										<c:forEach items="${productInfo.attachments}" var="attachment" varStatus="fileCnt">
										<c:if test="${attachment.thumbnail eq 'Y'}">
										<div id="thumbnail${vs.count}-${fileCnt.count}" class="carousel slide" data-bs-ride="carousel">
											<div class="carousel-inner">
											<div class="card carousel-item ${ fileCnt.count==1 ? 'active' : ''}" data-bs-interval="2000" style="width: 10rem;">
												<img alt="상품이미지" 
			                                        class="img-thumbnail d-block w-100"
			                                        src="${pageContext.request.contextPath}/resources/upload/product/${attachment.imageRenamedFilename}">
											</div>
											</div>
										</div>
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
											<p>[${productDetail.optionName}] ${productDetail.optionValue} (+${productDetail.additionalPrice})</p>
										</c:if>
									</c:forEach>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</c:if>
					
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