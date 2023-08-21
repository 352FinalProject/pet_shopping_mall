<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Image Slider Example</title>
<!-- Bootstrap CSS 포함 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">


<title>반려동물 쇼핑몰</title>
</head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/swiper.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/product.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/serviceCenter.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/review.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/sidebar.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/point.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/cartOrder.css" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>


<body>
	<sec:authorize access="isAuthenticated()">
		<form:form name="memberLogoutFrm"
			action="${pageContext.request.contextPath}/member/memberLogout.do"
			method="POST">
		</form:form>
	</sec:authorize>
	<header>
		<div class="header">
			<span id="notification"></span>
			<ul class="utility">
			<sec:authorize access="isAuthenticated()">
				권한 : <sec:authentication property="authorities"/>
				아이디 : <sec:authentication property="principal.username"/>
			</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<li class="login_li"><a
						href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
					</li>
					<li class="signup_li"><a
						href="${pageContext.request.contextPath}/member/terms.do">회원가입</a>
					</li>
				</sec:authorize>
				<li class="logout_li"><a
					href="${pageContext.request.contextPath}/servicecenter/service.do">고객센터</a>
				</li>
				<li class="admin_li"><a
					href="${pageContext.request.contextPath}/admin/admin.do">관리자페이지</a>
				</li>
				<sec:authorize access="isAuthenticated()">
					<li>
						<button class="" type="button"
							onclick="document.memberLogoutFrm.submit();">로그아웃</button>
					</li>
					<form action="/member/deleteMember.do" method="post"
						onsubmit="return confirm('정말로 회원 탈퇴를 진행하시겠습니까?');">
						<button type="submit">회원 탈퇴</button>
					</form>
				</sec:authorize>
				<li class="community_li"><a
					href="<%=request.getContextPath()%>/community/community.do">펫스토리</a>
				</li>
				<li class="community_li"><a
					href="<%=request.getContextPath()%>/review/reviewCreate.do">리뷰작성</a>
				</li>
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
					<div class="cdt">
						<!-- 검색 -->
						<div class="search_top_btn">
							<!-- 검색 창 -->
							<div class="search_box">
								<form name="searchBoxForm" id="searchBoxForm" action="">
									<img
										src="${pageContext.request.contextPath}/resources/images/home/search.png"
										id="center-image" alt="검색" />
								</form>
							</div>
						</div>
						<!-- 주문조회 -->
						<div class="order_checks_top_btn">
							<a href="${pageContext.request.contextPath}/member/myPage.do">
								<img
								src="${pageContext.request.contextPath}/resources/images/home/login.png"
								id="center-image" alt="주문조회" />
							</a>
						</div>
						<!-- 장바구니 -->
						<div class="cart_top_btn">
							<a href="${pageContext.request.contextPath}/cart/shoppingCart.do">
								<img
								src="${pageContext.request.contextPath}/resources/images/home/cart.png"
								id="center-image" alt="장바구니" />
							</a>
						</div>
					</div>
				</div>
			</div>
			<div class="menu-container">
				<ul class="nav">
					<ul>
						<li class="on"><a
							href="${pageContext.request.contextPath}/product/productList.do"
							class="font">사료</a></li>
						<li><a
							href="${pageContext.request.contextPath}/product/productList.do"
							class="font">간식</a></li>
						<li><a
							href="${pageContext.request.contextPath}/product/productList.do"
							class="font">패션용품</a></li>
						<li><a
							href="${pageContext.request.contextPath}/product/productList.do"
							class="font">산책용품</a></li>
						<li><a
							href="${pageContext.request.contextPath}/product/productList.do"
							class="font">위생용품</a></li>
						<li><a
							href="${pageContext.request.contextPath}/product/productList.do"
							class="font">장난감</a></li>
						<li><a
							href="${pageContext.request.contextPath}/product/productList.do"
							class="font">고양이</a></li>
						<li><a
							href="${pageContext.request.contextPath}/product/productList.do"
							class="font">기타용품</a></li>
					</ul>
				</ul>
			</div>
		</div>
	</header>
	<jsp:include page="/WEB-INF/views/common/chatIconSide.jsp"></jsp:include>