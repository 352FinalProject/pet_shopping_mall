<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
.cart-left div:not(:last-child){
	margin-bottom:5px;
}
.shopping-div {
display: flex;
}
.cart-product-info {
	width: 460px;
	height: 170px;
	border: 1px solid #e7e7e7;
	padding: 10px;
	display: flex;
	align-items: center;
}
#cart-option {
	display: flex;
}
#cart-option div:last-child{
	margin-left:140px;
}
.cart-left {
    margin-right: 30px; 
}




.cart-right {
    margin-left: 30px;
}
.payment-info {
	width: 400px;
	border: 1px solid #e7e7e7;
	padding: 10px;	
}
.product-price {
	display:flex;
    width: 100%; 
    justify-content: space-between;
    margin-top:5px;
}
.price {
font-size:24px;
}
.cart-btn {
	border: 1px solid #e7e7e7;
	background: white;
	padding:5px;
	border-radius: 2px;
}
#order-btn {
	margin-top:20px;
	width:100%;
	cursor: pointer;
}
</style>
    <section class="common-section" id="#">
        <div class="common-title">
            장바구니
        </div>
        <div class="common-container">
            <div class="common-div">
            	<div class="shopping-div">
	                <div class="cart-left">
	                	<div>
	                		<input type="checkbox" name="checkAll" id="checkAll">
	                		<label for="checkAll">전체 선택</label>
	                	</div>
	                	
	                	<c:forEach items="cart" var="product">
	                	<div class="cart-product-info">
	                		<div class="product-thumbnail"><img src="${pageContext.request.contextPath}/resources/images/product/sampleImg.jpg" width="110px"></div>
	                		<div>
	                			<div>
	                				<input type="checkbox" name="products">
	                				<label>리드줄 목줄 소형견 리드줄</label>
	                			</div>
	                			<div>
	                				<div id="cart-option">
	                					<div>
	                						<p>옵션: 노란색</p>
	                						<p>수량: 1개</p>
	                					</div>
	                					<div>
	                						<button class="cart-btn">옵션/수량변경</button>
	                					</div>
	                				</div>
	                				<div>
	                					<p>총 상품 금액 11,100원</p>
	                				</div>
	                			</div>
	                		</div>
	                	</div>
	                	</c:forEach>
	                	
	                	<div>
	                		<button class="cart-btn">선택 상품 삭제</button>
	                		<button class="cart-btn">전체 상품 삭제</button>
	                	</div>
	                </div>
	                <div class="cart-right">
						<span>결제금액</span>
						<div class="payment-info">
							<div>
								<div class="product-price">
									<span class="price"><strong>상품금액</strong></span>
									<p>11,100원</p>
								</div>
								<div class="product-price">
									<span>배송비</span>
									<p><span>(+)</span>3,000원</p>
								</div>
								<div class="product-price">
									<span>쿠폰 및 정립금</span>
									<p><span>(-)</span>3,000원</p>
								</div>
							</div>
						</div>
						<div class="payment-info">
							<div class="product-price">
								<strong class="price">최종 결제 금액</strong>
								<p class="price">11,100원</p>
							</div>
						</div>
						<div>
							<button class="btn btn1" id="order-btn" onclick="payment();">주문하기</button>
						</div>          
	                </div>
                </div>
            </div>
        </div>
    </section>
<script>
const products = document.querySelectorAll('input[name="products"]');
const orderButton = document.getElementById("order-btn");
const checkAll = document.querySelector("#checkAll");

console.log(products);

/* products.forEach(term => {
	products.addEventListener("change", () => {
        updateButtonColor();
    });
});

const updateButtonColor = () => {
    products.forEach(product => {
    	product.checked ? orderButton.classList.add("active") : orderButton.classList.remove("active");
    })
}; */

const payment = () => {
	window.location.href = '${pageContext.request.contextPath}/payment/paymentInfo.do';
};
</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>