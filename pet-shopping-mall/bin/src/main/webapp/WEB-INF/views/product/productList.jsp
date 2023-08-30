<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!-- CSS link -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css" />
<style>
section.product-board {
	display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin: 50px 100px 0px 100px;
    padding: 0 0 60px 0;
    border-bottom: 1px solid gray;
}
.board-title {
    text-align: center;
    font-size: 30px;
    padding-top: 40px;
    padding-bottom: 30px;
}
.board-category {
	padding: 0x 0px 60px;
}
.board-category .nav ul {
    font-size: 16px;
    gap: 70px;
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
	
    <section class="common-section" id="#" style="background-color:green;" >
    	<div class="common-container" style="background-color:magenta">
    		<div class="product-div">
    			<div class="product-left">
    				<img src="${pageContext.request.contextPath}/resources/images/1690801774638.jpg" width=300px />
    			</div>
    			<div class="product-right">
    				<div id="product-title">상품명 입니다.</div>
    				<div id="product-detail">상품설명란입니다.</div>
    			</div>
    		</div>
    </section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>