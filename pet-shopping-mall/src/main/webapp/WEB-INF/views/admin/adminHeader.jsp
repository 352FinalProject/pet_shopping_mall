<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<title>관리자 페이지</title>

<link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
</head>
<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-white">
		<!-- Navbar Brand-->
		<a class="navbar-brand ps-3" href="${pageContext.request.contextPath}/">
			<img src="${pageContext.request.contextPath}/resources/images/home/adminLogo.png" class="adminLogo" alt="로고" />
		</a>
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
							</div> <div class="navContent">대시보드</div>
						</a>
						<div class="sb-sidenav-menu-heading">회원목록</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminMemberList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> <div class="navContent">전체 회원목록</div>
						</a> <a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminSubscribeList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> <div class="navContent">구독 회원목록</div>
						</a>
						<div class="sb-sidenav-menu-heading">상품</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminProductList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> <div class="navContent">상품목록</div>
						</a>
						<div class="sb-sidenav-menu-heading">주문</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminOrderList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> <div class="navContent">주문목록</div>
						</a>
						<div class="sb-sidenav-menu-heading">매출</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminStatisticsProduct.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-chart-area"></i>
							</div> <div class="navContent">상품별 매출</div>
						</a> 
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminStatisticsByDate.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-chart-area"></i>
							</div> <div class="navContent">날짜별 매출</div>
						</a> 
						<div class="sb-sidenav-menu-heading">문의관련</div>
						<a class="nav-link" href="${pageContext.request.contextPath}/admin/adminQuestionList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> <div class="navContent">문의 관리</div>
						</a>
					</div>
				</div>
			</nav>
		</div>