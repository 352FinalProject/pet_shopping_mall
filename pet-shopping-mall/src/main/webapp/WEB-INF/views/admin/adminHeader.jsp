<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>관리자 페이지</title>

<link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

</head>
<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<!-- Navbar Brand-->
		<a class="navbar-brand ps-3" href="${pageContext.request.contextPath}/">펫쇼핑몰</a>
		<!-- Sidebar Toggle-->
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!">
			<i class="fas fa-bars"></i>
		</button>
	</nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<a class="nav-link"	href="${pageContext.request.contextPath}/admin/admin.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 대시보드
						</a>
						<div class="sb-sidenav-menu-heading">회원목록</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminMemberList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 전체 회원목록
						</a> <a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminSubscribeList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 구독 회원목록
						</a>
						<div class="sb-sidenav-menu-heading">상품</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminProductList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 상품목록
						</a>
						<div class="sb-sidenav-menu-heading">주문</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminOrderList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 주문목록
						</a>
						<div class="sb-sidenav-menu-heading">매출</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminStatisticsProduct.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-chart-area"></i>
							</div> 상품별 매출
						</a> 
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminStatisticsByDate.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-chart-area"></i>
							</div> 날짜별 매출
						</a> 
						<div class="sb-sidenav-menu-heading">문의관련</div>
						<a class="nav-link" href="${pageContext.request.contextPath}/admin/adminQuestionList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 문의 관리
						</a>
					</div>
				</div>
			</nav>
		</div>