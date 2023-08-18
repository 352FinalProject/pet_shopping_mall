<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="common-section" id="#">
	<div class="common-title">결제</div>
	<div class="common-container">
		<div class="common-div">
			<div class="payment-div">
				<div class="payment-left">
					<sec:authentication property="principal" var="loginMember" />
					<c:set var="amount" value="0" />
					<c:forEach items="${cartList}" var="product" varStatus="vs">
						<div class="cart-product-info">
							<c:set var="productTotal"
								value="${(product.productPrice + product.additionalPrice) * product.quantity}" />
							 <c:set var="amount" value="${amount + productTotal}" />
							<div class="product-thumbnail">
								<img
									src="${pageContext.request.contextPath}/resources/images/product/sampleImg.jpg"
									width="110px">
							</div>
							<div>
								<div>
									<p id="buy-title">${product.productName}</p>
								</div>
								<div>
									<div id="cart-option">
										<div>
											<p>
												옵션 : ${product.optionName} ${product.optionValue} <span>(+${product.additionalPrice})</span>
											</p>
											<p>수량 : ${product.quantity}개</p>
										</div>
									</div>
									<div>
										<p>상품 금액 ${productTotal}원</p>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<div class="order-info">
						<div>
							<p class="order-info-title">주문자</p>
						</div>
						<p>${loginMember.name}</p>
						<p>${loginMember.phone}</p>
					</div>
					<div>
						<div class="flex-box">
							<p class="order-info-title">배송지</p>
							<button class="cart-btn">수정</button>
						</div>
						<p id="">${loginMember.name}</p>
						<p id="phone">${loginMember.phone}</p>
						<p>
							[<span id="zip-code">818181</span>]<span id="address">${loginMember.address}</span>
						</p>
					</div>
					<div>
						<div class="order-info-title">결제수단</div>
						<div>
							<label class="paybtn"> <input type="radio"
								name="paymethod" value="trans"> <span>무통장입금</span>
							</label> <label class="paybtn"> <input type="radio"
								name="paymethod" value="html5_inicis"> <span>카드결제</span>
							</label>
							<label class="paybtn"> <input type="radio"
								name="paymethod" value="kakaopay"> <span>카카오페이</span>
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
								<p>
									<span id="total-price">${productTotal}</span>원
								</p>
							</div>
							<div class="product-price">
								<span>배송비</span>
								<p>
									<span>(+)</span><span id="delivery-fee">3,000</span>원
								</p>
							</div>
							<div class="product-price">
								<span>쿠폰 및 포인트</span>
								<p>
									<span>(-)</span><span id="discount">${pointCurrent}</span>원
								</p>
							</div>
						</div>
					</div>
					<div class="payment-info">
						<div class="product-price">
							<strong class="price">최종 결제 금액</strong>
							<p class="price">
								<span id="amount">${amount}</span>원
							</p>
						</div>
					</div>
					<div>
						<p>약관동의</p>
						<input type="checkbox" id="checkAll" name="checkAll" /><label>전체
							동의하기</label><br /> <input type="checkbox" name="terms" /><label>쇼핑몰
							이용약관 동의<span class="essential-check">(필수)</span>
						</label><br /> <input type="checkbox" name="terms" /><label>개인정보
							제 3자 제공 동의<span class="essential-check">(필수)</span>
						</label><br />
					</div>
					<div>
						<button class="btn btn1" id="order-btn" onclick="proceedPay();">결제하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>

let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");

$(function() {
    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
});

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


/* 결제 전 주문 페이지에 주문 정보를 담는다 */

const proceedPay = () => {
	/* 주문 테이블에 들어갈 값 */
	const checkedButton = document.querySelector('.paybtn input[type="radio"]:checked');
	
	console.log(checkedButton);
	
	let title;
	let cartListLength = ${fn:length(cartList)};

	if (cartListLength === 1) {
		title = "${cartList[0].productName}";
	} else if (cartListLength > 1) {
		title = "${cartList[0].productName}" +" 외" + (cartListLength - 1) + "개";
	}
	
	const data = {
		orderNo: new Date().getTime(),
		memberId: '${loginMember.memberId}',
		name: '${loginMember.name}',
		title: title,
		buyerTel: '${loginMember.phone}',
		buyerEmail: '${loginMember.email}',
		buyerAddr: '${loginMember.address}',
		postcode: 1,
		totalPrice: '${productTotal}',
		deliveryFee: 3000,
		discount: '${pointCurrent}',
		amount: '${amount}',
		pg: checkedButton.value
	};
	
	console.log(data);
	
	$.ajax({
		url: '${pageContext.request.contextPath}/payment/proceed.do',
		type: 'POST',
		async: true,
		contentType:'application/json',
		data : JSON.stringify(data),
		success(response) {
			console.log(response);
			if(response.result > 0){
				alert('주문하시겠습니까?')
				requestPaymentByCard(data);
			} else {
				alert(response.msg);
			}
		}
	});

};


const requestPaymentByCard = (data) => {
	
	IMP.init('imp60204862');
	/* 2. 결제 데이터 정의 */
	IMP.request_pay({
		pg : data.pg,                         // PG사
    	pay_method: "card",
    	merchant_uid: data.orderNo,   // 주문번호
    	name: data.title,
    	amount: 1000,                         // 숫자 타입
    	buyer_email: data.buyerEmail,
    	buyer_name: data.name,
    	buyer_tel: data.buyerTel,
    	buyer_addr: "쓰레기통",
    	buyer_postcode: "01181"
	}, 
	function (response) {
		console.log(response)
 		$.ajax({
			type: 'POST',
			url : '${pageContext.request.contextPath}/payment/verifyIamport/' + response.imp_uid,
		}).done((data) =>  {
			if(response.paid_amount == data.response.amount) {
				alert("결제 완료");
			} else {
				alert("결제 실패")
			}
		})
	});
};

/* 			beforeSend : function(xhr){
xhr.setRequestHeader(header, token);
} */

</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />