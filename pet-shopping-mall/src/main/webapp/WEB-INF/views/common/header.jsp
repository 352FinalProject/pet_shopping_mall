<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>반려동물 쇼핑몰</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>

   
<body>

<header>
    <div class="header">
        <span id="notification"></span>
        <ul class="utility">
            <li class="login_li">
                <a href="<%= request.getContextPath() %>/product/productDetail.do">샘플</a>
            </li>
            <li class="login_li">
                <a href="<%= request.getContextPath() %>/member/login.do">로그인</a>
            </li>
            <li class="signup_li">
                <a href="<%= request.getContextPath() %>/member/terms">회원가입</a>
            </li>
			<li class="logout_li">
			        <a href="<%= request.getContextPath() %>/member/logout">고객센터</a>
			</li>
        </ul>
        <div class="logo_top_wrap">
	        <div class="logo_wrap">
	        	<!-- 로고 이미지 -->
		        <div class="logo_img">
		         	<a href="${pageContext.request.contextPath}/">
		            	<img src="${pageContext.request.contextPath}/resources/images/home/logo.png" id="center-image" alt="로고"/>
		        	</a>
		        </div>
		    <div class="cdt">
		        <!-- 검색 -->
		        <div class="search_top_btn">
		        <!-- 검색 창 -->
		        	<div class="search_box">
		        		<form name="searchBoxForm" id="searchBoxForm" action="">
		        			<img src="${pageContext.request.contextPath}/resources/images/home/search.png" id="center-image" alt="검색"/>
		        		</form>
		        	</div>
		        </div>
		        <!-- 주문조회 -->
		        <div class="order_checks_top_btn">
		        	<img src="${pageContext.request.contextPath}/resources/images/home/login.png" id="center-image" alt="주문조회"/>
		        </div>
		        <!-- 장바구니 -->
		        <div class="cart_top_btn">
		        	<img src="${pageContext.request.contextPath}/resources/images/home/cart.png" id="center-image" alt="장바구니"/>
		       	</div>
		    	</div>
	        </div>
	    </div>
        <div class="menu-container">
            <ul class="nav">
                <ul>
                    <li class="on">
                        <a href="${pageContext.request.contextPath}/product/productList.do" class="font">사료</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/product/productList.do" class="font">간식</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/product/productList.do" class="font">패션용품</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/product/productList.do" class="font">산책용품</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/product/productList.do" class="font">위생용품</a>
                    </li>
                     <li>
                        <a href="${pageContext.request.contextPath}/product/productList.do" class="font">장난감</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/product/productList.do" class="font">고양이</a>
                    </li>
                     <li>
                        <a href="${pageContext.request.contextPath}/product/productList.do" class="font">기타용품</a>
                    </li>
                </ul>
            </ul>
        </div>
    </div>
</header>