<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>반려동물 쇼핑몰 관리자페이지</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/serviceCenter.css" />

   
<body>

<header>
    <div class="header">
        <span id="notification"></span>
        <ul class="utility">
        	<li class="admin_li">
			        오늘:15, 어제: 150, 최대:552, 전체: 159,229
			</li>
			<li class="admin_li">
			        <a href="<%= request.getContextPath() %>/admin/admin.do">관리자홈</a>
			</li>
			<li class="admin_li">
			        <a href="<%= request.getContextPath() %>/admin/admin.do">로그아웃</a>
			</li>
        </ul>
        
        <div class="menu-container">
            <ul class="nav">
                <ul>
                    <li class="on">
                        <a href="${pageContext.request.contextPath}/admin/adminMemberList.do" class="font">회원관리</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/~~.do" class="font">구독자관리</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/~~.do" class="font">상품관리</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/~~.do" class="font">주문관리</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/~~.do" class="font">통계분석</a>
                    </li>
                     <li>
                        <a href="${pageContext.request.contextPath}/admin/~~.do" class="font">디자인관리</a>
                    </li>
                     <li>
                        <a href="${pageContext.request.contextPath}/admin/~~.do" class="font">기타용품</a>
                    </li>
                </ul>
            </ul>
        </div>
    </div>
</header>