<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <style>
    .btn {
    cursor: pointer;
	width:150px;
	height:50px;
	border-radius: 5px;
	border:none;
	margin: auto;
	}
	.product-bottom {
	display: flex;
	width: 100%;
	position:fixed;
	margin-bottom: 730px;
	background-color: #fff;
	font-size:18px;
	justify-content: center;
	height: 80px;
	border-top: 1px solid #999999;
	}
	.product-bottom div{
	margin-top:10px;
	margin-right:40px;
	}
	.btn2 {
	cursor: pointer;
	background: #58ACFA;
	margin: auto;
	}
	.cart-btn1 {
	gap: 10px;
	display: flex;
	}
    </style>
    <section>
    	<div class="product-bottom">
    		<div>
    			<span>제품명 나오는 곳</span>
    			<br />
    			<span>11,000원</span>
    		</div>
    		<div>
    			<img src="${pageContext.request.contextPath}/resources/images/product/pink_heart.png" width="30px""/>
    			<br />
    			<span>1,562</span>
    		</div>
    		<div class="cart-btn1">
    			<button class="btn btn1">장바구니</button>
    			<button class="btn btn2">구매하기</button>
    		</div>
    	</div>
    </section>