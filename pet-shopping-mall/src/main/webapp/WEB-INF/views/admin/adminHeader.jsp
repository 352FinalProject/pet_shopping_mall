<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>반려동물 쇼핑몰 관리자페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberLogin.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/serviceCenter.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
</head>
<body>

	<header>
		<span id="notification"></span>
		<ul class="utility">
			<li class="admin_li">오늘:15, 어제: 150, 최대:552, 전체: 159,229</li>
			<li class="admin_li"><a
				href="<%=request.getContextPath()%>/admin/admin.do">관리자홈</a></li>
			<li class="admin_li"><a
				href="<%=request.getContextPath()%>/admin/admin.do">로그아웃</a></li>
		</ul>
		<div class="logo_top_wrap">
			<div class="logo_wrap">
				<!-- 로고 이미지 -->
				<div class="logo_img">
					<a href="${pageContext.request.contextPath}/"> <img
						src="${pageContext.request.contextPath}/resources/images/home/logo.png"
						id="center-image" alt="로고" />
					</a>
				</div>

			</div>
		</div>

		<div class="menu-container">
			<ul class="nav">
				<ul>
					<li class="on"><a
						href="${pageContext.request.contextPath}/admin/adminMemberList.do"
						class="font">회원관리</a></li>
					<li><a
						href="${pageContext.request.contextPath}/admin/adminSubscribeList.do"
						class="font">구독자관리</a></li>
					<li><a
						href="${pageContext.request.contextPath}/admin/adminProductList.do"
						class="font">상품관리</a></li>
					<li><a
						href="${pageContext.request.contextPath}/admin/adminOrderList.do"
						class="font">주문관리</a></li>
					<li><a
						href="${pageContext.request.contextPath}/admin/adminStatistics.do"
						class="font">통계분석</a></li>
					<li><a
						href="${pageContext.request.contextPath}/admin/adminMemberList.do"
						class="font">디자인관리</a></li>
					<li><a
						href="${pageContext.request.contextPath}/admin/adminQuestionList.do"
						class="font">문의관리</a></li>
				</ul>
			</ul>
		</div>
		</div>
	</header>