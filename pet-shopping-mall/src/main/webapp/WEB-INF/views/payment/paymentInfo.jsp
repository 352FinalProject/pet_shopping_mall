<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
.payment-left div:not(:last-child){
	margin-bottom:20px;
}
.payment-div {
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

.payment-left {
    margin-right: 30px; 
}




.payment-right {
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
}
.order-info-title{
	font-size:19px;
	margin-right:3px;
	
}
.flex-box {
	display: flex;
}

/*버튼 활성화 시 색상 변경하려고 만든 클래스*/
.active {
	background-color: #5886d3;
}
</style>
    <section class="common-section" id="#">
        <div class="common-title">
            장바구니
        </div>
        <div class="common-container">
            <div class="common-div">
            	<div class="payment-div">
	                <div class="payment-left">
	                	<div class="cart-product-info">
	                		<div class="product-thumbnail"><img src="${pageContext.request.contextPath}/resources/images/product/sampleImg.jpg" width="110px"></div>
	                		<div>
	                			<div>
	                				<p>리드줄 목줄 소형견 리드줄</p>
	                			</div>
	                			<div>
	                				<div id="cart-option">
	                					<div>
	                						<p>옵션: 노란색</p>
	                						<p>수량: 1개</p>
	                					</div>
	                				</div>
	                				<div>
	                					<p>총 상품 금액 11,100원</p>
	                				</div>
	                			</div>
	                		</div>
	                	</div>
	                	<div class="order-info">
	                		<div>
	                			<p class="order-info-title">주문자</p>
	                		</div>
	                		<p>홍길동</p>
	                		<p>010-1234-1234</p>
	                	</div>
	                	<div>
	                		<div class="flex-box">
	                			<p class="order-info-title">배송지</p><button class="cart-btn">수정</button>
	                		</div>
	                		<p>홍길동</p>
	                		<p>010-1234-1234</p>
	                		<p>[우편번호] KH정보교육원</p>
	                	</div>
	                	<div>
	                		<div class="order-info-title">결제수단</div>
	                		<div>
	                			<button id="pay-by-cash" class="btn btn1">무통장입금</button>
	                			<button id="pay-by-card" class="btn btn1">카드결제</button>
	                		</div>
	                	</div>
	                	
	                </div>
	                <div class="payment-right">
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
							<p>약관동의</p>
							<input type="checkbox" id="checkAll" name="checkAll"/><label>전체 동의하기</label><br />
							<input type="checkbox" name="terms"/><label>쇼핑몰 이용약관 동의<span class="essential-check">(필수)</span></label><br />
							<input type="checkbox" name="terms"/><label>개인정보 제 3자 제공 동의<span class="essential-check">(필수)</span></label><br />
						</div>
						<div>
							<button class="btn btn1" id="order-btn">결제하기</button>
						</div>          
	                </div>
                </div>
            </div>
        </div>
    </section>
<script>
const checkAll = document.getElementById("checkAll");
const terms = document.getElementsByName("terms");
const orderButton = document.getElementById("order-btn");
const checkboxes = document.querySelectorAll('input[type="checkbox"]');

let flag = false;

checkboxes.forEach(checkbox => {
    checkbox.addEventListener("change", () => {
        if (checkbox === checkAll) {
            terms.forEach(term => {
                term.checked = checkAll.checked;
            });
        } else {
            checkAll.checked = terms[0].checked && terms[1].checked;
        }
        updateButtonColor();
    });
});

terms.forEach(term => {
    term.addEventListener("change", () => {
        updateButtonColor();
    });
});

const updateButtonColor = () => {
    checkAll.checked ? orderButton.classList.add("active") : orderButton.classList.remove("active")
};

</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>