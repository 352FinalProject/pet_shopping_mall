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
				<div class="card-body">
					김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원</div>
			</div>

			<div class="admin-product-search-container">
				<form method="GET" class="admin-product-search">
					<label for="searchKeyword">검색어:</label> <select
						name="searchCategory">
						<option value="productName">상품명</option>
						<option value="productCode">상품코드</option>
					</select> <input type="text" id="searchKeyword" name="searchKeyword"
						placeholder="상품명 또는 상품코드"><br> <label for="minStock">재고검색:</label>
					<input type="number" id="minStock" name="minStock"> ~ <label
						for="maxStock"></label> <input type="number" id="maxStock"
						name="maxStock"><br> <label>판매 여부:</label> <input
						type="radio" id="saleStatusAll" name="saleStatus" value="all">
					<label for="saleStatusAll">전체</label> <input type="radio"
						id="saleStatusSoldOut" name="saleStatus" value="soldOut">
					<label for="saleStatusSoldOut">품절</label> <input type="radio"
						id="saleStatusDiscontinued" name="saleStatus" value="discontinued">
					<label for="saleStatusDiscontinued">단종</label> <input type="radio"
						id="saleStatusPaused" name="saleStatus" value="paused"> <label
						for="saleStatusPaused">중지</label><br>
					<button type="submit">검색</button>
				</form>
			</div>

			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-table me-1"></i> 기본상품목록
					<input type="button" value="글쓰기" id="btn-add"/>
				</div>
				<div class="card-body">
					<table id="datatablesSimple">
						<thead>
							<th>상품아이디</th>
							<th>이미지</th>
							<th>상품명</th>
							<th>카테고리</th>
							<th>상품가격</th>
							<th>옵션명</th>
							<th>옵션값</th>
							<th>옵션추가금</th>
							<th>판매상태</th>
							<th>관리</th>
						</thead>
						<tbody>

							<c:if test="${empty productInfos}">
								<td colspan="5">등록된 상품이 없습니다.</td>
							</c:if>
							<c:if test="${not empty productInfos}">
								<c:forEach items="${productInfos}" var="productInfo" varStatus="vs">
									<tr>
										<td>${productInfo.product.productId}</td>
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
										<td>${productInfo.optionName}</td>
										<td>${productInfo.optionValue}</td>
										<td>${productInfo.additionalPrice}</td>
										<td>${productInfo.saleState}</td>
										<td>
											<button onclick="deleteProduct();">삭제</button> 
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
	const deleteProduct = () => {
		
	};
	
	document.querySelector("#btn-add").onclick = () => {
		location.href = '${pageContext.request.contextPath}/admin/adminProductDetailCreate.do';
	};
	</script>
	<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>