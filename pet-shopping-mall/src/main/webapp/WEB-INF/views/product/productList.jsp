<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
section.product-board {
	display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin: 50px 100px 0px 100px;
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
    margin: 0 100px;
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
    border-color: #051619;
    border-style: solid;
    border-width: 0 0 0 1px;
    z-index: 10px;
}
.product-card {
    box-sizing: border-box;
    position: relative;
    text-decoration: none;
    display: block;
    width: 25%;
    /* color: #051619; */
    /* border: 1px solid #051619; */
    /* border-width: 0 1px 1px 0; */
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
    box-sizing: border-box;
}
.product-card .product-desc .product-name {
    margin: 0 0 0.5rem;
    font-size: 1.25rem;
}
.product-card .product-desc .product-price {
    margin: 0 0 0.5rem;
    font-size: 1.25rem;
}
.product-card .product-desc .review-star {

}
.product-card .product-desc .review-cnt {
    margin: 0 0 0.5rem;
    font-size: 0.9rem;
}

</style>
	
	<section class="product-board">
        <div class="board-title"">
	        <span>사료</span>
        </div>
        <div class="board-category">
            <ul class="nav">
                   <li class="on">
                       <a href="#" class="font">건식</a>
                   </li>
                   <li>
					<a href="#" class="font">화식</a>
                   </li>
                   <li>
					<a href="#" class="font">습식</a>
                   </li>
                   <li>
					<a href="#" class="font">생식</a>
                   </li>
                   <li>
					<a href="#" class="font">고양이</a>
                   </li>
            </ul>
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
			<div class="product-card">
				<a href="${pageContext.request.contextPath}/product/productDetail.do">
				<figure class="product-thumbnail">
					<img alt="썸네일이미지" src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg">
				</figure>
				<div class="product-desc">
					<p class="product-name">강아지 리드줄 목줄</p>
					<p class="product-price">10,000원</p>
					<span class="reviewstar">⭐</span> | 
					<span class="review-cnt">후기 113건</span>
				</div>
				</a>
			</div>
			<div class="product-card">
				<a href="${pageContext.request.contextPath}/product/productDetail.do">
				<figure class="product-thumbnail">
					<img alt="썸네일이미지" src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg">
				</figure>
				<div class="product-desc">
					<p class="product-name">강아지 리드줄 목줄</p>
					<p class="product-price">10,000원</p>
					<span class="reviewstar">⭐</span> | 
					<span class="review-cnt">후기 113건</span>
				</div>
				</a>
			</div>
			<div class="product-card">
				<a href="${pageContext.request.contextPath}/product/productDetail.do">
				<figure class="product-thumbnail">
					<img alt="썸네일이미지" src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg">
				</figure>
				<div class="product-desc">
					<p class="product-name">강아지 리드줄 목줄</p>
					<p class="product-price">10,000원</p>
					<span class="reviewstar">⭐</span> | 
					<span class="review-cnt">후기 113건</span>
				</div>
				</a>
			</div>
			<div class="product-card">
				<a href="${pageContext.request.contextPath}/product/productDetail.do">
				<figure class="product-thumbnail">
					<img alt="썸네일이미지" src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg">
				</figure>
				<div class="product-desc">
					<p class="product-name">강아지 리드줄 목줄</p>
					<p class="product-price">10,000원</p>
					<span class="review-star">⭐</span> | 
					<span class="review-cnt">후기 113건</span>
				</div>
				</a>
			</div>
		</ul>
	</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>