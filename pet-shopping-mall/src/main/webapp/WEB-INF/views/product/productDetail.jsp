<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<style>
	.common-section{
	display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    
    margin:100px;
	}
	.common-container {
	width: 1000px;
	}
	.product-div {
	display: flex;
    align-items: center;
    justify-content: space-around;

	}
	#product-title {
	
	}
	#product-detail {
	
	}
	.util-div{
	height:50px;
	margin-top:30px;
	font-size : 18px;
	}
	.common-container2 {
	display: flex;
    justify-content: center;
    align-items: center;
	}
	#product-title{
	font-size: 26px;
	}
	.product-info div {
	margin:15px;
	}

	.product-assist {
	display:flex;
	justify-content: space-between;
	font-size:19px;
	}
	.product-utility{
	display: flex;
	justify-content: space-around;
	}
	select[name=product-option] {
	width:100%;
	font-size: 20px;
	heiht: 40px;
	}
	#price-info {
	font-size: 22px;
	font-weight: 500;
	}
	    .btn {
	width:150px;
	height:50px;
	border-radius: 5px;
	border:none;
	}
	.product-bottom {
	display: flex;
	width: 100%;
	position:fixed;
	margin-bottom: 430px;
	background-color: #fff;
	font-size:15px;
	justify-content: center;
	height: 80px;
	border-top: 1px solid #999999;
	}
	.product-bottom div{
	margin-top:10px;
	margin-right:40px;
	}
	.btn2 {
	background: #58ACFA;
	}
	#product-bottom-title{
	font-size:20px;
	}
	</style>
    <section class="common-section" id="#" >
    	<div class="common-container">
    		<div class="product-div">
    			<div class="product-img">
    				<img src="${pageContext.request.contextPath}/resources/images/product/sampleImg.jpg" width=400px />
    			</div>
    			<div class="product-info">
    				<div id="product-title">이탈리아에서 찍은 어떤 고양이 귀엽죠</div>
    				<div class="product-assist">
						<div id="price-info">11,000원</div>
						<div class="product-assist">
							<span>⭐</span><span>5.0</span>
							<span>&nbsp;|&nbsp;</span>
							<span><a href="#">후기 102건</a></span>
						</div>
    				</div>
    				<hr>
    				<div>
	    				<img src="${pageContext.request.contextPath}/resources/images/product/won.png" width="30px"> 적립금 <br />
	    				구매 적립금 110원 <br />
	    				리뷰 적립금(텍스트) 500원 <br />
	    				리뷰 적립금(사진) 1,000원 <br />
    				</div>
    				<hr>
    				<div> 
	    				<img src="${pageContext.request.contextPath}/resources/images/product/shipped.png" width="30px"> 배송 <br />
	    				배송비 3,000원(30,000원이상 구매시 무료배송) <br />
	    				오후 1시 이전 주문 시 오늘 출발 <br />
    				</div>
    				<div>
    					<select name="product-option">
    						<option value=''>[필수]옵션선택</option>
    						<option value=''>귀여워요</option>
    					</select>
    				</div>
    			</div>
    		</div>
    		<div class="util-div">
    			<ul class="product-utility">
    				<li><a href="#">상품정보</a></li>
    				<li><a href="#">상품후기</a></li>
    				<li><a href="#">교환/반품/배송</a></li>
    				<li><a href="#">1:1문의</a></li>
    			</ul>
    		</div>
    		<div class="common-container2">
    			<div><img src="${pageContext.request.contextPath}/resources/images/1690801774638.jpg" width=500px></div>
    		</div>
    	</div>
    	<div class="product-bottom">
    		<div>
    			<span id="product-bottom-title">제품명 나오는 곳</span>
    			<br />
    			<span>11,000원</span>
    		</div>
    		<div>
    			<img src="${pageContext.request.contextPath}/resources/images/product/pink_heart.png" width="28px"/>
    			<br />
    			<span>1,562</span>
    		</div>
    		<div>
    			<button class="btn btn1">장바구니</button>
    			<button class="btn btn2">구매하기</button>
    		</div>
    	</div>
    </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>