<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="admin-product-search-container">
    <form method="GET" class="admin-product-search">
        <label for="searchKeyword">검색어:</label>
        <select name="searchCategory">
            <option value="productName">상품명</option>
            <option value="productCode">상품코드</option>
        </select>
        <input type="text" id="searchKeyword" name="searchKeyword" placeholder="상품명 또는 상품코드"><br>
        <label for="minStock">재고검색:</label>
        <input type="number" id="minStock" name="minStock"> ~
        <label for="maxStock"></label>
        <input type="number" id="maxStock" name="maxStock"><br>
        <label>판매 여부:</label>
        <input type="radio" id="saleStatusAll" name="saleStatus" value="all">
        <label for="saleStatusAll">전체</label>
        <input type="radio" id="saleStatusSoldOut" name="saleStatus" value="soldOut">
        <label for="saleStatusSoldOut">품절</label>
        <input type="radio" id="saleStatusDiscontinued" name="saleStatus" value="discontinued">
        <label for="saleStatusDiscontinued">단종</label>
        <input type="radio" id="saleStatusPaused" name="saleStatus" value="paused">
        <label for="saleStatusPaused">중지</label><br>
        <button type="submit">검색</button>
    </form>
</div>

<table class="table table-striped table-hover">
	<thead class="table-dark">
		<tr>
			<th>번호</th>
			<th>이미지</th>
			<th>상품코드</th>
			<th>상품명</th>
			<th>시중가</th>
			<th>공급가</th>
			<th>판매가</th>
			<th>포인트</th>
			<th>재고</th>
			<th>순위</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach begin="0" end="20" step="1" varStatus="status">
			<tr>
				<th>번호</th>
				<th><a href="#" />이미지</th>
				<th><a href="#" />상품코드</th>
				<th><a href="#" />상품명</th>
				<th>시중가</th>
				<th>공급가</th>
				<th>판매가</th>
				<th>포인트</th>
				<th>재고</th>
				<th>순위</th>
				<td><button onclick="">수정</button> <button onclick="">삭제</button></td>
			</tr>
		</c:forEach>
	</tbody>
</table>


















<jsp:include page="/WEB-INF/views/common/footer.jsp" />