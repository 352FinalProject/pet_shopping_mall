<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="//css/index.css" />
    <title>유기견/유기묘 입양 사이트</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />

   
<body>

<header>
    <div class="header">
        <div class="logo_img">
            <a href="<%= request.getContextPath() %>"><img src="/hairball/images/로고/메뉴바_로고.png" alt=""/></a>
        </div>
        	<span id="notification"></span>
        <ul class="utility">
             <li class="admin_li">
                 <a href="<%= request.getContextPath() %>/animal/enroll">관리자</a>
             </li>
            <li class="login_li">
                <a href="<%= request.getContextPath() %>/member/login">로그인</a>
            </li>
            <li class="login_li">
                <a href="<%= request.getContextPath() %>/member/memberDetail">마이페이지</a>
            </li>
            <li class="signup_li">
                <a href="<%= request.getContextPath() %>/member/terms">회원가입</a>
            </li>
			    <li class="logout_li">
			        <a href="<%= request.getContextPath() %>/member/logout">로그아웃</a>
			    </li>
        </ul>
        <div class="menu-container">
            <ul class="nav">
                <ul>
                    <li class="on">
                        <a href="<%= request.getContextPath() %>" class="font">홈</a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/introduce/introduce1.jsp" class="font">소개</a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/animal/procedure" class="font">보호동물</a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/animal/animalAdoptionList" class="font">입양신청</a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/qnaBoard/questionIntro" class="font">참여소통</a>
                    </li>
                </ul>
            </ul>
        </div>
    </div>
</header>