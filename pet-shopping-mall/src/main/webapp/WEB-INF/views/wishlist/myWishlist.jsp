<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
	.container {
	    margin: 0 auto; /* 가운데 정렬을 위해 수평 마진을 자동으로 설정 */
	    max-width: 1200px; /* 컨테이너의 최대 너비 설정 */
	}
	
	.sub_title {
	    font-size: 32px;
	    font-weight: bold;
	    text-align: center; /* 텍스트를 가운데 정렬 */
	    line-height: 120px; /* 높이 지정을 통해 텍스트 세로 가운데 정렬 */
	}
	
	.list {
	    display: flex; /* 플렉스 컨테이너로 설정하여 아이템을 가로로 나열 */
	    flex-wrap: wrap; /* 아이템이 줄 바꿈되도록 설정 */
	}
	
	/* 이미지 크기 관련 스타일 */
	.listImgSize {
	    width: 220px; /* 이미지의 너비를 지정 */
	    height: 200px !important; /* 이미지의 높이를 지정 (중요도 강조) */
	}
	
	.box {
	    width: 230px;
	    height: 400px;
	    margin-right: 25px; /* 오른쪽 여백 추가 */
	}
	
	.box>img {
	    width: 100%; /* 이미지를 부모 요소에 맞게 100%로 설정 */
	    height: 275px; /* 이미지의 높이 지정 */
	    object-fit: cover; /* 이미지의 가로세로비를 유지하면서 채우기 */
	    margin-bottom: 10px; /* 이미지 아래 여백 추가 */
	    cursor: pointer; /* 커서를 손가락 모양으로 변경하여 클릭 가능함을 나타냄 */
	}
	
	.box p {
	    font-size: 14px;
	    margin: 0;
	    padding-bottom: 10px; /* 단락 아래 여백 추가 */
	}
	
	.box h5 {
	    margin: 0;
	    line-height: 20px;
	    font-size: 16px;
	}
	
	.box span {
	    font-size: 14px;
	}
	
	.box span img {
	    width: 10px;
	    height: 10px;
	    object-fit: cover;
	    margin-right: 5px; /* 이미지 우측 여백 추가 */
	}
	
	.box:nth-child(4n) {
	    margin-right: 0; /* 4번째 아이템의 오른쪽 여백 제거 */
	}
	
	/* 이미지 크기 조정 관련 CSS */
	.box img {
	    height: auto; /* 이미지의 높이 자동 조정으로 비율 유지 */
	    max-height: 275px; /* 이미지의 최대 높이 지정 */
	}
	
	.nextDiv {
	    float: left; /* 왼쪽으로 플로팅 */
	    margin-left: 35%; /* 왼쪽 여백 추가하여 가운데 정렬 */
	}
    </style>
</head>

<body>
    <div class="common-section">
        <div class="common-title">찜 목록</div>
        
        <div class="list nextDiv">
            <c:forEach items="${myWishList}" var="list">
                <div class="box">
                    <a href="<c:url value='/product/productDetail.do'/>?productId=${list.PRODUCT_ID}">
                        <img class="listImgSize" src="${pageContext.request.contextPath}/resources/upload/product/${list.IMAGE_RENAMED_FILENAME}" alt="">
                        <p>${list.PRODUCT_NAME}</p>
                        <h5><fmt:formatNumber value="${list.PRODUCT_PRICE}" pattern="#,###"/> 원</h5>
                        <span><img src="${pageContext.request.contextPath }/resources/images/상품/star.png" alt="">5.0 | 후기
                            153건</span>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</body>

</html>
