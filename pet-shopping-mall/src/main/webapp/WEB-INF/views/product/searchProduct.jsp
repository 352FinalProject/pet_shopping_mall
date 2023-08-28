<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
section.product-board {
	display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin: 50px 0px 0px 0px;
    padding: 0 0 60px 0;
    border-bottom: 1px solid #e7e7e7;
}
ul.nav {
    background: #fff;
    margin: 0 auto;
    display: flex;
    justify-content: center;
}
ul.nav {
    display: flex;
    font-size: 16px;
    gap: 109px;
}
.product-sort ul.nav {
	padding: 8px;
    background: #fff;
    margin: 0 auto;
    display: flex;
    /* justify-content: center; */
    gap: 8px;
    justify-content: flex-end;
    margin: 0 10px;
}
.product-sort ul.nav .font{
	color : #828282;
}
.board-title {
    text-align: center;
    font-size: 30px;
    padding-top: 40px;
    padding-bottom: 30px;
}
.board-category {
	padding: 0x 0px 60px;
	display: flex;
    align-items: center;
    margin-top: 11px;
    padding-bottom: 11px;
}
.board-category .nav ul {
    font-size: 16px;
    gap: 70px;
}
.on {
	color: blue;
}
.product-gallery {
	max-width: 1200px;
	margin: 0 auto;
}
.gallery {
	display: flex;
    flex-wrap: wrap;
    position: relative;
    z-index: 10px;
}
.product-card {
    box-sizing: border-box;
    position: relative;
    text-decoration: none;
    display: block;
    width: 25%;
    cursor: pointer;
    padding: 5px;
}
.product-card .product-thumbnail {
	box-sizing: border-box;
    position: relative;
    margin: 0 5px;
    padding-bottom: 75%;
    /* border-bottom: 1px solid #051619; */
    border-radius: 0;
    overflow: hidden;
}
.product-card .product-thumbnail img {
	position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.product-card .product-desc {
    padding: 1.5rem 1.75rem;
    color : #828282;
    box-sizing: border-box;
}
.product-card .product-desc .product-name {
    margin: 0 0 0.5rem;
    font-size: 1.25rem;
}
.product-card .product-desc .product-price {
    margin: 0 0 0.5rem;
    font-size: 1.25rem;
    font-weight: 500;
}
.product-card .product-desc .review-star img {
    width: 15px;
    height: 15px;
    margin-right: 4px;
}
.product-card .product-desc .review-cnt {
    margin: 0 0 0.5rem;
    font-size: 0.9rem;
    font-weight: 400;
}

#not-found {
	font-size: 24px;
	text-align: center;
	margin-top: 30px;
}

.product-category {
	display: flex;
}
.category-id {
	font-size:28px;
	font-weight: 700;
	margin: 20px;
	
}
</style>
<div class="common-section">

	<!-- 컨테이너 -->
	<div class="common-container">
		<section class="product-board">
			<!-- 게시판 이름 -->
	        <div class="board-title">
		        <span>
		        상품 조회 결과 (${fn:length(productInfos)}건 조회)
		        </span>
	        </div>
		</section>
		
		<!-- 상품사진 갤러리 -->
        <div class="product-gallery">
            <c:if test="${empty productInfos}">
                <div id="not-found">조회된 결과가 없습니다.</div>
            </c:if>
            <c:if test="${not empty productInfos}">
                <c:set var="categories" value="사료&간식,패션&산책,위생&기타,고양이" />
                <c:forEach items="${fn:split(categories, ',')}" var="category">
                    <div class="category-id">${category}</div>
                    <div class="product-category">
                        <c:forEach items="${productInfos}" var="productInfo" varStatus="vs">
                            <c:choose>
                                <c:when test="${productInfo.categoryId == 1 || productInfo.categoryId == 2}">
                                    <c:set var="categoryName" value="사료&간식" />
                                </c:when>
                                <c:when test="${productInfo.categoryId == 3 || productInfo.categoryId == 4}">
                                    <c:set var="categoryName" value="패션&산책" />
                                </c:when>
                                <c:when test="${productInfo.categoryId == 5 || productInfo.categoryId == 7}">
                                    <c:set var="categoryName" value="위생&기타" />
                                </c:when>
                                <c:otherwise>
                                    <c:set var="categoryName" value="고양이" />
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${categoryName eq category}">
                                <div class="product-card">
                                    <a href="${pageContext.request.contextPath}/product/productDetail.do?productId=${productInfo.productId}&reviewId=${reviewId.reviewId}">
                                        <!-- Your product card content here -->
                                        <figure class="product-thumbnail">
											<img alt="썸네일이미지" src="${pageContext.request.contextPath}/resources/upload/product/${productInfo.imageRenamedFileName}">
										</figure>
										<div class="product-desc">
											<p class="product-name">${productInfo.productName}</p>
											<p class="product-price"><fmt:formatNumber value="${productInfo.productPrice}" pattern="#,###" /> 원</p>
											<span class="review-star"><img src="${pageContext.request.contextPath}/resources/images/상품/star.png" alt="별점" ><span>5.0</span></span>
											<span> &nbsp;|&nbsp; </span>
											<span class="review-cnt">후기 113건</span>
										</div>
                                    </a>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:forEach>
            </c:if>
        </div>
		
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>