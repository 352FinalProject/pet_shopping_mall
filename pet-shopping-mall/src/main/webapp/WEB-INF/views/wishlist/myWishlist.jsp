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
    /* 컨테이너 스타일 */
    .container {
        margin: 0 auto;
        max-width: 1200px;
    }

    /* 소제목 스타일 */
    .sub_title {
        font-size: 32px;
        font-weight: bold;
        text-align: center;
        line-height: 120px;
    }

    /* 찜 목록 리스트 스타일 */
    .list {
        display: flex;
        flex-wrap: wrap;
    }

    /* 이미지 크기 스타일 */
    .listImgSize {
        width: 220px;
        height: 200px !important;
    }

    /* 각 상자 스타일 */
    .box {
        width: 230px;
        height: 400px;
        margin-right: 25px;
    }

    /* 이미지 스타일 */
    .box>img {
        width: 100%;
        height: 275px;
        object-fit: cover;
        margin-bottom: 10px;
        cursor: pointer; /* 클릭 가능한 커서 스타일 */
    }

    /* 제목 스타일 */
    .box p {
        font-size: 14px;
        margin: 0;
        padding-bottom: 10px;
    }

    /* 가격 정보 스타일 */
    .box h5 {
        margin: 0; /* 상하좌우 여백을 0으로 설정하여 디폴트 여백 제거 */
        line-height: 20px; /* 텍스트의 줄 간격을 조정 */
        font-size: 16px;
    }

    /* 리뷰 스타일 */
    .box span {
        font-size: 14px;
    }

    /* 리뷰 이미지 스타일 */
    .box span img {
        width: 10px;
        height: 10px;
        object-fit: cover;
        margin-right: 5px;
    }

    /* 네 번째 상자 스타일 (오른쪽 여백 없애기) */
    .box:nth-child(4n) {
        margin-right: 0;
    }

    /* 이미지 크기 조정 관련 스타일 */
    .box img {
        height: auto; /* 세로 비율 유지 */
        max-height: 275px; /* 최대 높이 지정하여 늘어짐 방지 */
    }

    /* 다음 부분 스타일 */
    .nextDiv {
        float: right;
        margin-left: 10%;
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
						<span class="review-star"><img src="${pageContext.request.contextPath}/resources/images/상품/star.png" alt="별점" >
						<c:if test="${productInfo.productReviewStarAvg.reviewStarRate == null}">
							<span>0.0</span>
						</c:if>
						<c:if test="${productInfo.productReviewStarAvg.reviewStarRate != 0}" >
							<span>${productInfo.productReviewStarAvg.reviewStarRate}</span>
						</c:if>
						</span>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</body>

</html>