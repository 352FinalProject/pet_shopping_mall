<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Image Slider Example</title>
<!-- Bootstrap CSS 포함 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
    .heart-button {
        display: inline-block;
        font-size: 24px;
        color: black; /* 검은색 하트의 기본 색상 */
        cursor: pointer;
    }
    
    .heart-button.pink {
        color: pink; /* 핑크색 하트 */
    }
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<section class="common-section" id="#">
    <div class="common-container">
        <!-- 상품 정보 -->
        <div class="product-div">
            <div class="product-img">
                <!-- 상품 이미지 -->
                <img src="${pageContext.request.contextPath}/resources/images/product/sampleImg.jpg" width=400px />
            </div>
            <div class="product-info">
                <div id="product-title">이탈리아에서 찍은 어떤 고양이 귀엽죠</div>
                <div class="product-assist">
                    <div id="price-info">11,000원</div>
                    <div class="product-assist">
                        <!-- 별점 및 후기 정보 -->
                        <img src="${pageContext.request.contextPath}/resources/images/상품/star.png" alt="별점">
                        <span>5.0</span>
                        <span>&nbsp;|&nbsp;</span>
                        <span><a href="#">후기 102건</a></span>
                    </div>
                </div>
                <hr class="hr-line">
                <!-- 적립금 정보 -->
                <div class="won_img">
                    <img src="${pageContext.request.contextPath}/resources/images/product/won.png" width="30px">
                    <div class="won_text">적립금</div>
                </div>
                <div class="won_desc">
                    구매 적립금 110원 <br />
                    리뷰 적립금(텍스트) 500원 <br />
                    리뷰 적립금(사진) 1,000원 <br />
                </div>
                <hr class="hr-line">
                <!-- 배송 정보 -->
                <div class="shipped_img">
                    <img src="${pageContext.request.contextPath}/resources/images/product/shipped.png" width="30px">
                    <div class="shipped_text">배송</div>
                </div>
                <div class="shipped_desc">
                    배송비 3,000원(30,000원이상 구매시 무료배송) <br />
                    오후 1시 이전 주문 시 오늘 출발 <br />
                </div>
                <hr class="hr-line">
                <!-- 선택 옵션 -->
                <div>
                    <select name="product-option">
                        <option value=''>[필수]옵션선택</option>
                        <option value=''>귀여워요</option>
                    </select>
                </div>
                <div class="product-price">
                    <div class="product-price-desc">
                        총 상품 금액 <span>11,000</span>원
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 상품 후기 -->
        <div class="util-div">
            <ul class="product-utility">
                <li><a href="#">상품정보</a></li>
                <li><a href="#">상품후기</a></li>
                <li><a href="#">교환/반품/배송</a></li>
                <li><a href="#">1:1문의</a></li>
            </ul>
        </div>
        
        <!-- 리뷰 정보 -->
        <div class="review-div">
            <ul class="review-product-utility">
                <c:if test="${empty reviews}">
                    작성된 리뷰가 없습니다.
                </c:if>
                <c:if test="${not empty reviews}">
                    <c:forEach items="${reviews}" var="review" varStatus="vs">
                        <li>
                            <div class="review-box">
                                <div class="review-info-box">
                                    <!-- 회원 정보 -->
                                    <em class="review-info-id">${review.reviewMemberId}</em>
                                    <em class="review-info-date">
                                        <fmt:parseDate value="${review.reviewCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
                                        <fmt:formatDate value="${createdAt}" pattern="yyyy.MM.dd"/>
                                    </em>
                                </div>
                                <div class="review-detail-box">
                                    <!-- 리뷰 제목, 별점, 사진, 내용 -->
                                    <div class="score_star">
                                        <c:choose>
                                            <c:when test="${review.reviewStarRate == 1}">
                                                <span class="star-rating">★☆☆☆☆</span> (1)
                                            </c:when>
                                            <c:when test="${review.reviewStarRate == 2}">
                                                <span class="star-rating">★★☆☆☆</span>  (2)
                                            </c:when>
                                            <c:when test="${review.reviewStarRate == 3}">
                                                <span class="star-rating">★★★☆☆</span> (3)
                                            </c:when> 
                                            <c:when test="${review.reviewStarRate == 4}">
                                                <span class="star-rating">★★★★☆</span> (4)
                                            </c:when>
                                            <c:when test="${review.reviewStarRate == 5}">
                                                <span class="star-rating">★★★★★</span> (5)
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <div class="review-warp">
                                        <!-- 리뷰 내용 -->
                                    </div>
                                    <div class="review-data-wrap">
                                        <span class="review-data"></span>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
        
        <!-- 페이징 바 -->
        <nav aria-label="...">
            <ul class="pagination pagination-sm">
                <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                    <li class="page-item ${page == pageNumber ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/product/productDetail.do?page=${pageNumber}">
                            <span class="page-number">${pageNumber}</span>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
        
   <div class="product-bottom">
        <div class="product-bottom2">
            <div>
                <span id="product-bottom-title">${productInfo.productName}</span> <br /> <span>11,000원</span>
            </div>
            <div class="heart-img">
                <div class="heart-button" id="heartButton" onclick="toggleHeart()">
                    <c:choose>
                        <c:when test="${likeState == 0}">
                            ♡
                        </c:when>
                        <c:otherwise>
                            ♥
                        </c:otherwise>
                    </c:choose>
                </div>
                <span>${productInfo.likeCnt}</span>
            </div>
            <div>
                <button class="btn btn1">장바구니</button>
                <button class="btn btn2">구매하기</button>
            </div>
        </div>
    </div>
</section>
<script>
    function toggleHeart() {
        var heartButton = document.getElementById("heartButton");
        if (heartButton.classList.contains("pink")) {
            heartButton.classList.remove("pink");
        } else {
            heartButton.classList.add("pink");
        }
        
        // 여기에 하트를 클릭했을 때 동작할 JavaScript 코드를 추가할 수 있습니다.
        // 예를 들어, 서버로 AJAX 요청을 보내거나 상태를 업데이트하는 등의 동작을 할 수 있습니다.
    }
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
