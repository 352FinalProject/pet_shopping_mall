<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="//css/index.css" />
    <title>반려동물 쇼핑몰</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper.css" />

   
<body>

<header>
    <div class="header">
        <span id="notification"></span>
        <ul class="utility">
            <li class="login_li">
                <a href="<%= request.getContextPath() %>/member/sample.do">샘플</a>
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
        <div class="logo_img">
            <img src="${pageContext.request.contextPath }/resources/images/홈/logo.png" id="center-image" alt="로고" class="d-block mx-auto mt-5"/>
        </div>
        <div class="menu-container">
            <ul class="nav">
                <ul>
                    <li class="on">
                        <a href="#" class="font">사료</a>
                    </li>
                    <li>
                        <a href="#" class="font">간식</a>
                    </li>
                    <li>
                        <a href="#" class="font">패션용품</a>
                    </li>
                    <li>
                        <a href="#" class="font">산책용품</a>
                    </li>
                    <li>
                        <a href="#" class="font">위생용품</a>
                    </li>
                     <li>
                        <a href="#" class="font">장난감</a>
                    </li>
                    <li>
                        <a href="#" class="font">고양이</a>
                    </li>
                     <li>
                        <a href="#" class="font">기타용품</a>
                    </li>
                </ul>
            </ul>
        </div>
    </div>
</header>