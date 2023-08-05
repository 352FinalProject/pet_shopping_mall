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
    justify-content: center;
    align-items: center;

	}
	#product-title {
	
	}
	#product-detail {
	
	}
	.util-div{
	height:50px;
	background-color: blue;
	}
	.common-container2 {
	display: flex;
    justify-content: center;
    align-items: center;
	}
	</style>
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
    		<div class="util-div">
    			<ul class="utility">
    				<li><a href="#">제품 상세</a></li>
    				<li><a href="#">후기</a></li>
    				<li><a href="#">QnA</a></li>
    			</ul>
    		</div>
    		<div class="common-container2">
    			<div><img src="${pageContext.request.contextPath}/resources/images/1690801774638.jpg" width=500px></div>
    		</div>
    	</div>
    </section>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>