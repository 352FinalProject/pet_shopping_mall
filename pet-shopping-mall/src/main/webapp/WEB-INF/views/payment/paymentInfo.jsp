<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

.paybtn input[type="radio"] {
	display: none;
}
.paybtn input[type="radio"]+span {
    display: inline-block;
    border: 1px solid #c8c8c8;
    background-color: #ffffff;
    text-align: center;
    cursor: pointer;
    border-radius: 5px;
    padding: 10px;
    width: 150px;
}
.paybtn input[type="radio"]:checked+span {
    background-color: #5886d3;
    color: #ffffff;
}
</style>
    <section class="common-section" id="#">
        <div class="common-title">
            결제
        </div>
        <div class="common-container">
            <div class="common-div">
            	<div class="payment-div">
	                <div class="payment-left">
	                	<c:forEach items="${cartList}" var="product" varStatus="vs">
	                	<div class="cart-product-info">
	                		<c:set var="totalPrice" value="${price + product.productPrice}"/>
	                		<div class="product-thumbnail"><img src="${pageContext.request.contextPath}/resources/images/product/sampleImg.jpg" width="110px"></div>
	                		<div>
	                			<div>
	                				<p id="buy-title">${product.productName}</p>
	                			</div>
	                			<div>
	                				<div id="cart-option">
	                					<div>
	                						<p>옵션 : ${product.optionName} ${product.optionValue} <span>(+${product.additionalPrice})</span></p>
	                						<p>수량 : ${product.quantity}개</p>
	                					</div>
	                				</div>
	                				<div>
	                					<p>상품 금액 ${(product.productPrice + product.additionalPrice) * product.quantity}원</p>
	                				</div>
	                			</div>
	                		</div>
	                	</div>
	                	</c:forEach>
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
	                		<p id="">홍길동</p>
	                		<p id="phone">010-1234-1234</p>
	                		<p>[<span id="zip-code">818181</span>]<span id="address">KH정보교육원</span></p>
	                	</div>
	                	<div>
	                		<div class="order-info-title">결제수단</div>
	                		<div>
	                			<label class="paybtn">
							    	<input type="radio" name="paymethod" value="cash">
							    	<span>무통장입금</span>
								</label>
							 
								<label class="paybtn">
							    	<input type="radio" name="paymethod" value="card">
							    	<span>카드결제</span>
								</label>
	                		</div>
	                	</div>
	                </div>
	                <div class="payment-right">
						<span>결제금액</span>
						<div class="payment-info">
							<div>
								<div class="product-price">
									<span class="price"><strong>상품금액</strong></span>
									<p><span id="total-price">${totalPrice}</span>원</p>
								</div>
								<div class="product-price">
									<span>배송비</span>
									<p><span>(+)</span><span id="delivery-fee">3,000</span>원</p>
								</div>
								<div class="product-price">
									<span>쿠폰 및 포인트</span>
									<p><span>(-)</span><span id="discount">${pointCurrent}</span>원</p>
								</div>
							</div>
						</div>
						<div class="payment-info">
							<div class="product-price">
								<strong class="price">최종 결제 금액</strong>
								<p class="price"><span id="amount">${totalPrice}</span>원</p>
							</div>
						</div>
						<div>
							<p>약관동의</p>
							<input type="checkbox" id="checkAll" name="checkAll"/><label>전체 동의하기</label><br />
							<input type="checkbox" name="terms"/><label>쇼핑몰 이용약관 동의<span class="essential-check">(필수)</span></label><br />
							<input type="checkbox" name="terms"/><label>개인정보 제 3자 제공 동의<span class="essential-check">(필수)</span></label><br />
						</div>
						<div>
							<button class="btn btn1" id="order-btn" onclick="proceedPay();">결제하기</button>
						</div>          
	                </div>
                </div>
            </div>
        </div>
    </section>
<script>

/* 이용약관 버튼 색상 조정 */
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


/* 결제 관련 js */

let orderCnt = 100;

const orderNumber = () => {
  const currentDate = new Date();
  const year = currentDate.getFullYear().toString().slice(-2);
  const month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
  const day = currentDate.getDate().toString().padStart(2, '0');

  return `\${year}\${month}\${day}` + (orderCnt++);
	
}

/* 결제 전 주문 페이지에 주문 정보를 담는다 */

const proceedPay = () => {
	/* 주문 테이블에 들어갈 값 */
	const data = {
		orderNo: orderNumber(),
		memberId: 'honggd',
		totalPrice: 11000,
		deliveryFee: 3000,
		discount: 3000,
		amount: 11000
	}
	$.ajax({
		url: '${pageContext.request.contextPath}/payment/proceed.do',
		type: 'POST',
		async: true,
		contentType:'application/json',
		data : JSON.stringify(data),
		success(response) {
			console.log(response);
			if(response.result > 0){
				alert('주문 ㄱㄱ?');
				requestPaymentByCard(data)
			} else {
				alert(response.msg);
			}
		}
	});

};


const requestPaymentByCard = (data) => {
	const {IMP} = window;
	IMP.init('imp60204862');
	
	/* 2. 결제 데이터 정의 */
	IMP.request_pay({
		pg: 'html5_inicis',                           // PG사
        pay_method: 'card', 
        merchant_uid: data.orderNo,  // 주문번호
        amount: 100,                                 // 결제금액
        name: '테스트입니다요',                   // 주문명
        buyer_name: '김담희',                           // 구매자 이름
        buyer_tel: '010-1234-1234',                     // 구매자 전화번호
        buyer_email: 'dami@naver.com',               // 구매자 이메일
        buyer_addr: '모현읍ㅎ',                    // 구매자 주소
        buyer_postcode: '12031',                      // 구매자 우편번호
	}, 
	function (response) {
		console.log(response)
 		$.ajax({
			type: 'POST',
			url : '${pageContext.request.contextPath}/payment/verifyIamport/' + response.imp_uid
		}).done((data) =>  {
			if(response.paid_amount == data.response.amount) {
				alert("결제 완료");
			} else {
				alert("결제 실패")
			}
		})
	});
};


document.addEventListener("DOMContentLoaded", function() {
    const productInfos = document.querySelectorAll(".cart-product-info");
    
    productInfos.forEach(productInfo => {
        const details = productInfo.querySelector(".product-details");
        productInfo.addEventListener("click", () => {
            details.style.display = details.style.display === "block" ? "none" : "block";
        });
    });
});




</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>