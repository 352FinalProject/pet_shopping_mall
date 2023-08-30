<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
</style>
<div class="common-section">

	<!-- 컨테이너 -->
	<div class="common-container">
		<section class="product-board">
			<!-- 게시판 이름 -->
	        <div class="board-title">
		        <span>
		        ${productCategory.categoryName} 
		        </span>
	        </div>
		</section>
		
		<!-- 정렬 선택란 -->
		<div class="product-sort">
			<ul class="nav">
				<li>
					<a href="#" class="font">신상품</a>
				</li>
				<li>
					<a href="#" class="font">낮은가격</a>
				</li>
				<li>
					<a href="#" class="font">높은가격</a>
				</li>
				<li>
					<a href="#" class="font">리뷰많은순</a>
				</li>
				<li>
					<a href="#" class="font">판매량순</a>
				</li>
			</ul>
		</div>
		
		<!-- 상품사진 갤러리 -->
		<div class="product-gallery">
			<ul class="gallery">
			<c:forEach items="${productInfos}" var="productInfo" varStatus="vs">
				<div class="product-card">
                    <a href="${pageContext.request.contextPath}/product/productDetail.do?productId=${productInfo.product.productId}&reviewId=${reviewId.reviewId}">
					<figure class="product-thumbnail">
						<img alt="썸네일이미지" src="${pageContext.request.contextPath}/resources/upload/product/${productInfo.attachments[0].imageRenamedFilename}">
					</figure>
					<div class="product-desc">
						<p class="product-name">${productInfo.product.productName}</p>
						<p class="product-price"><fmt:formatNumber value="${productInfo.product.productPrice}" pattern="#,###" />원</p>
						<div class="product-desc2">
							<span class="review-star"><img src="${pageContext.request.contextPath}/resources/images/상품/star.png" alt="별점" ><span>5.0</span></span>
							<span> &nbsp;|&nbsp; </span>
							<span class="review-cnt">후기 ${reviewTotalCount}건</span>
						</div>
					</div>
					</a>
				</div>
			</c:forEach>
			</ul>
		</div>
	</div>

</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>