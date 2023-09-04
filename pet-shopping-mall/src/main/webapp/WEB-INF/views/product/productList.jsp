<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="common-section">
	<!-- 컨테이너 -->
	<div class="common-container">
		<section class="product-board">
			<!-- 게시판 이름 -->
	        <div class="board-title">
		        <span>
		        <c:set var="categoryName" value="${productInfos[0].categoryName}"/>
		        <c:set var="categoryId" value="${productInfos[0].categoryId}" />
		        ${categoryName}
		        </span>
	        </div>
		</section>
		<div class="product-sort">
			<ul class="nav">
				<li>
					<a href="#" class="font" onclick="setSortOption('신상품')">신상품</a>
				</li>
				<li>
					<a href="#" class="font" onclick="setSortOption('낮은가격')">낮은가격</a>
				</li>
				<li>
					<a href="#" class="font" onclick="setSortOption('높은가격')">높은가격</a>
				</li>
				<li>
					<a href="#" class="font" onclick="setSortOption('별점높은순')">별점높은순</a>
				</li>
				<li>
					<a href="#" class="font" onclick="setSortOption('리뷰많은순')">리뷰많은순</a>
				</li>
			</ul>
		</div>
		<form:form id="alignFrm" name="alignFrm" method="get" action="${pageContext.request.contextPath}/product/productList.do">
		    <input type="hidden" name="categoryId" value="${category.categoryId}"/>
		    <input type="hidden" name="align" id="align" value=""/>
	    	<input type="hidden" name="page" value="1"/>
		</form:form>
		<!-- 상품사진 갤러리 -->
		<div class="product-gallery">
			<ul class="gallery">
				<c:forEach items="${productInfos}" var="productInfo" varStatus="vs">
				<div class="product-card">
                    <a href="${pageContext.request.contextPath}/product/productDetail.do?productId=${productInfo.productId}">
					<figure class="product-thumbnail">
						<img alt="썸네일이미지" src="${pageContext.request.contextPath}/resources/upload/product/${productInfo.thumbnail}">
					</figure>
					<div class="product-desc">
						<p class="product-name">${productInfo.productName}</p>
						<p class="product-price"><fmt:formatNumber value="${productInfo.productPrice}" pattern="#,###" /> 원</p>
						<span class="review-star"><img src="${pageContext.request.contextPath}/resources/images/상품/star.png" alt="별점" >
							<span>${productInfo.reviewStarRate}</span>
						</span>
						<span> &nbsp;|&nbsp; </span>
						<span class="review-cnt">후기 ${productInfo.reviewCnt}건</span>
					</div>
					</a>
				</div>
				</c:forEach>
			</ul>
			<nav class="product-nav" aria-label="...">
				<ul class="pagination-product pagination-sm">
				  <c:forEach begin="1" end="${totalPages}" var="pageNumber">
					  <li class="page-item ${page == pageNumber ? 'active' : ''}">
						  <a class="page-link" href="${pageContext.request.contextPath}/product/productList.do?categoryId=${category.categoryId}&page=${pageNumber}">
							  <span class="page-number">${pageNumber}</span>
						  </a>
					  </li>
				  </c:forEach>
			  </ul>
		  </nav>
		</div>
	</div>
</div>
<script>
function setSortOption(sortOption) {
    document.getElementById('align').value = sortOption;
    console.log(sortOption);
    document.getElementById('alignFrm').submit();
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>