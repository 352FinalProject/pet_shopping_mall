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
					<select name="searchCategory">
						<option value="product_name">상품명</option>
						<!-- <option value="product_category">카테고리</option> -->
					</select> <input type="text" id="searchKeyword" name="searchKeyword" placeholder="상품명"><br> 
					
					<label>판매 여부:</label> 
					<input type="checkbox" id="saleStatusAll" onclick="selectAllStatus();">
					<label for="saleStatusAll">전체</label> 
					<input type="checkbox" id="saleStatusDiscontinued" name="saleState" value="0">
					<label for="saleStatusDiscontinued">판매대기</label> 
					<input type="checkbox" id="saleStatusOnSale" name="saleState" value="1">
					<label for="saleStatusOnSale">판매중</label> 
					<input type="checkbox" id="saleStatusSoldOut" name="saleState" value="2"> 
					<label for="saleStatusSoldOut">품절</label>
					<input type="checkbox" id="saleStatusOther" name="saleState" value="3"> 
					<label for="saleStatusOther">기타</label><br>
			        
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
							<th>이미지</th>
							<th>상품명</th>
							<th>카테고리</th>
							<th>상품가격</th>
							<th>옵션</th>
							<th>옵션추가금</th>
							<th>판매상태</th>
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
												<img style="width: 100px; height: 100px; margin-right: 10px;" alt="상품이미지" 
			                                        class="product-img"
			                                        src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg">
											</c:if>
											<c:if test="${not empty productInfo.attachments}">
												<img style="width: 100px; height: 100px; margin-right: 10px;" alt="상품이미지" 
			                                        class="product-img"
			                                        src="${pageContext.request.contextPath}/resources/upload/product/${productInfo.attachments[0].imageRenamedFilename}">
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
													<p>옵션없음</p>
												</c:if>
												<c:if test="${not empty productDetail.optionName}">
													<p>${productDetail.optionName} - ${productDetail.optionValue}</p>
												</c:if>
											</c:forEach>
										</td>
										<td>
											<c:forEach  items="${productInfo.productDetails}" var="productDetail" varStatus="pvs">
												<p>${productDetail.additionalPrice}</p>
											</c:forEach>
										</td>
										<td>
											<c:forEach  items="${productInfo.productDetails}" var="productDetail" varStatus="pvs">
												<p>
													<c:if test="${productDetail.saleState eq 0}">판매대기</c:if>
													<c:if test="${productDetail.saleState eq 1}">판매중</c:if>
													<c:if test="${productDetail.saleState eq 2}">품절</c:if>
													<c:if test="${productDetail.saleState eq 3}">기타</c:if>										
												</p>
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
	<script>
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