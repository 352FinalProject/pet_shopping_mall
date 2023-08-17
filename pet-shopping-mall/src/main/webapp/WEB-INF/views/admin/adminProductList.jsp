<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">주문 조회</h1>
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
				<form method="GET"
					action="${pageContext.request.contextPath}/admin/adminAddProduct.do">
					<button type="button">상품추가</button>
				</form>
			</div>



			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-table me-1"></i> 주문목록
				</div>
				<div class="card-body">
					<table id="datatablesSimple">
						<thead>
							<th>번호</th>
							<th>주문일시</th>
							<th>주문번호</th>
							<th>이미지</th>
							<th>주문상품</th>
							<th>수량</th>
							<th>상품금액</th>
							<th>배송비</th>
							<th>주문상태</th>
							<th>주문자</th>
							<th>총주문액</th>
							<th>결제방법</th>
						</thead>
						<tbody>
							<c:forEach begin="0" end="20" step="1" varStatus="status">
								<tr>
									<th>${status.count}</th>
									<th>주문일시</th>
									<th><a href="#" />주문번호</th>
									<th><a href="#" />이미지</th>
									<th><a href="#" />주문상품</th>
									<th>수량</th>
									<th>상품금액</th>
									<th>배송비</th>
									<th>주문상태</th>
									<th>주문자</th>
									<th>총주문액</th>
									<th>결제방법</th>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>