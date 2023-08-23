<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">상품별 매출</h1>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/adminStatisticsProduct.do">사료 상품별매출</a></li>
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/adminStatisticsProduct.do">간식 상품별매출</a></li>
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/adminStatisticsProduct.do">패션용품 상품별매출</a></li>
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/adminStatisticsProduct.do">위생용품 상품별매출</a></li>
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/adminStatisticsProduct.do">장난감 상품별매출</a></li>
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/adminStatisticsProduct.do">고양이 상품별매출</a></li>
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/adminStatisticsProduct.do">기타용품 상품별매출</a></li>
			</ol>
			<div class="card mb-4">
				<div class="card-body">
					카테고리별 매출 top5 이런식으로 보여주고,테이블로 카테고리별로 나워서 상품하나하나 정확한 통계치를 보여줘야됨 
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-chart-bar me-1"></i>전체 상품별 매출 top6
				</div>
				<div class="card-body">
					<canvas id="productChartBar" width="100%" height="40"></canvas>
				</div>
				<div class="card-footer small text-muted">Updated yesterday at
					11:59 PM</div>
			</div>
			
			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-table me-1"></i> 매출액 순위
				</div>
				<div class="card-body">
					<table id="datatablesSimple">
						<thead>
							<tr>
								<th>순위</th>
								<th>상품코드</th>
								<th>상품명</th>
								<th>카테고리</th>
								<th>상품가격</th>
								<th>판매수량</th>
								<th>판매액</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${productStatistics}" var="productStatistic" varStatus="vs">
								<tr>
									<td>${vs.count}</td>
									<td>${productStatistic.productId}</td>
									<td>${productStatistic.productName}</td>
									<td>${productStatistic.categoryName}</td>
									<td>${productStatistic.productPrice}</td>
									<td>${productStatistic.totalSold}</td>
									<td>${productStatistic.totalPrice}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			
			
			
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>