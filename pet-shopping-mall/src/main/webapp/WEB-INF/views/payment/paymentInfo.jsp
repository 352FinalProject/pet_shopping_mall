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
	<div class="common-title">주문/결제</div>
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
									src="${pageContext.request.contextPath}/resources/upload/product/${product.imageRenamedFileName}"
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
												옵션 : ${product.optionName} ${product.optionValue} <span>(+<fmt:formatNumber
														value="${product.additionalPrice}" groupingUsed="true" />)
												</span>
											</p>
											<p>수량 : ${product.quantity}개</p>
										</div>
									</div>
									<div class="productTotal-title">
										<p>
											상품 금액 <span class="productTotal-title2"><fmt:formatNumber
													value="${productTotal}" groupingUsed="true" /></span>원
										</p>
									</div>
								</div>
							</div>
						</div>
					<form:form name="orderDetailFrm">
						<input type="hidden" value="${product.productDetailId}" class="productDetailId" />
						<input type="hidden" value="${product.quantity}" class="quantity" />
					</form:form>
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
							<button class="cart-btn-update">수정</button>
						</div>
						<p id="">${loginMember.name}</p>
						<p id="phone">${loginMember.phone}</p>
						<p>
							[<span id="zip-code">818181</span>]<span id="address">${loginMember.address}</span>
						</p>
					</div>
					<div>
						<p class="order-info-title">결제수단</p>
						<div>
							<label class="paybtn"> <input type="radio"
								name="paymethod" value="trans"> <span>무통장입금</span>
							</label> <label class="paybtn"> <input type="radio"
								name="paymethod" value="html5_inicis"> <span>카드결제</span>
							</label> <label class="paybtn"> <input type="radio"
								name="paymethod" value="kakaopay"> <span>카카오페이</span>
							</label>
						</div>
					</div>
				</div>
				<div class="payment-right">
					<div class="payment-discount">
						<p class="order-info-title">할인수단</p>
						<div class="discount-info">
							<div>
								<div class="discount-point-info">
									<span class="discount-point">포인트</span> <input type="text"
										name="point-view" id="pointInput" class="point-view" value="0"
										style="width: 64px; text-align: right; margin-left: 10px;">원
									<button type="button" class="discount-point-btn">사용</button>
									<button type="button" class="discount-point-btn">모두사용</button>
									<span class="have-point"> (보유 <span
										class="have-point-bold" style="font-weight: 600"><fmt:formatNumber
												value="${pointCurrent}" groupingUsed="true" /></span>원 )
									</span>
								</div>
							</div>
						</div>
					</div>
					<p class="order-info-title">결제금액</p>
					<div class="payment-info">
						<div>
							<div class="product-price">
								<span class="price"><strong>상품금액</strong></span>
								<p>
									<span id="total-price"><fmt:formatNumber
											value="${productTotal}" groupingUsed="true" /></span>원
								</p>
							</div>
							<div class="product-price">
								<span>배송비</span>
								<p>
									<span>(+)</span><span id="delivery-fee">3,000</span>원
								</p>
							</div>
							<div class="product-price">
								<span>포인트</span>
								<p>
									<span style="color: red;">(-) <span id="discount">원</span></span>
								</p>
							</div>
							<div class="product-price">
								<span>쿠폰</span>
								<p>
									<span style="color: red;">(-) <span id="discount">원</span></span>
								</p>
							</div>
						</div>
					</div>
					<div class="payment-info2">
						<div class="product-price">
							<strong class="price-title">최종 결제 금액</strong>
							<p class="price">
								<span id="amount"><fmt:formatNumber value="${amount}"
										groupingUsed="true" /></span>원
							</p>
						</div>
					</div>
					<div>
						<p class="order-info-title">약관동의</p>
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
	
	let title;
	let cartListLength = ${fn:length(cartList)};

	if (cartListLength === 1) {
		title = "${cartList[0].productName}";
	} else if (cartListLength > 1) {
		title = "${cartList[0].productName}" +" 외" + (cartListLength - 1) + "개";
	}
	
    let pointValue = parseInt(document.getElementById('pointInput').value.replace(/,/g, '')) || 0;
	
    const forms = document.querySelectorAll('[name="orderDetailFrm"]');
	
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
		pointsUsed: pointValue,
		pg: checkedButton.value,
		
	};
	
	const formDatas = [];
	
	forms.forEach(form => {
		const productDetailId = form.querySelector('.productDetailId').value;
		const quantity = form.querySelector('.quantity').value;
		
		formDatas.push({
			productDetailId: productDetailId,
			quantity: quantity
		});
	});
	
	data.forms = formDatas;
	
	
	if(confirm('정말 주문하시겠습니까?')) {
		$.ajax({
			url: '${pageContext.request.contextPath}/payment/proceed.do',
			type: 'POST',
			async: true,
			contentType:'application/json',
			data : JSON.stringify(data),
			success(response) {
				console.log(response);
				if(response.result > 0){
					alert('주문을 진행합니다.');
					requestPaymentByCard(data);
				} else {
					alert('주문이 취소되었습니다.');
					location.href = "${pageContext.request.contextPath}/order/deleteOrder.do";
				}
			}
		});
	}
};


const requestPaymentByCard = (data) => {
	
	IMP.init('imp60204862');
	/* 2. 결제 데이터 정의 */
	IMP.request_pay({
		pg : data.pg,                         // PG사
    	pay_method: "card",
    	merchant_uid: data.orderNo,   // 주문번호
    	name: data.title,
    	amount: data.amount,                         // 숫자 타입
    	buyer_email: data.buyerEmail,
    	buyer_name: data.name,
    	buyer_tel: data.buyerTel,
    	buyer_addr: "쓰레기통",
    	buyer_postcode: "01181"
	}, 
	function (response) {
	    // 결제가 취소됐을 때 (예라)
	    if (!response.success && response.error_msg.includes("결제포기")) {
    		console.log("결제 취소됨");
		   	let orderData = {
		   			orderNo: new Date().getTime(),
		   			memberId: '${loginMember.memberId}',
		   			name: '${loginMember.name}',
		   			buyerTel: '${loginMember.phone}',
		   			buyerEmail: '${loginMember.email}',
		   			buyerAddr: '${loginMember.address}',
		   			postcode: 1,
		   			totalPrice: '${productTotal}',
		   			deliveryFee: 3000,
		   			discount: '${pointCurrent}',
		   			amount: '${amount}',
		   	};
	        $.ajax({
	            type: 'POST',
	            url : '${pageContext.request.contextPath}/payment/verifyAndHandleCancelledPayment/' + response.imp_uid,
	            data: JSON.stringify(orderData), // orderData를 JSON 문자열로 변환
	            contentType: "application/json", // 전송 데이터의 종류
	            dataType: "json", // 응답 데이터의 종류
	        }).done((data) =>  {
	            alert("결제가 취소되었습니다.");
	        });
	        return;
	    }
		
 		$.ajax({
			type: 'POST',
			url : '${pageContext.request.contextPath}/payment/verifyIamport/' + response.imp_uid,
		}).done((data) =>  {
			if(response.paid_amount == data.response.amount) {
				successPay(response.imp_uid, response.merchant_uid);
			}
		})
	});
}; 

const successPay = (imp_uid, merchant_uid) => {
	$.ajax({  
		 url : "${pageContext.request.contextPath}/payment/successPay.do",
		 type : "POST",
		 async : true,
		 dataType : "Json", 
		 data :{
			imp_uid: imp_uid,            // 결제 고유번호
         	merchant_uid: merchant_uid   // 주문번호 
		 },
		 success(data){
			if(data.result > 0){
         		alert("결제 및 검증 완료");
           		location.href="${pageContext.request.contextPath}/payment/paymentCompleted.do?orderNo=" + merchant_uid;
            }else{
              	alert("결제 완료 되었으나 에러 발생하였습니다. 관리자에게 문의하세요.")
              	location.href="${pageContext.request.contextPath}/member/mypage.do"
		 	}
		 }
	});
};


/* 포인트 사용하면 포인트에 금액 기재되고 최종 결제 금액에서 차감 (예라)*/
document.querySelector('.discount-point-btn').addEventListener('click', function() {
    // 포인트 입력 값 가져오기
    let pointValue = parseInt(document.getElementById('pointInput').value.replace(/,/g, '')) || 0;

    // 총 결제 금액에서 포인트 차감
    let amount = parseInt(document.getElementById('amount').innerText.replace(/,/g, '')) || 0;
    amount -= pointValue;

    // 포인트 차감 금액 업데이트
    document.getElementById('discount').innerText = pointValue.toLocaleString(); // 숫자를 쉼표 포함 문자열로 변환

    // 총 결제 금액 업데이트
    document.getElementById('amount').innerText = amount.toLocaleString();
});

/* 모두사용 버튼 누르면 현재 있는 모든 포인트 사용 (예라)*/
document.querySelectorAll('.discount-point-btn')[1].addEventListener('click', function() {
    // 현재 사용자의 포인트 가져오기
    let pointCurrent = parseInt(document.querySelector('.have-point-bold').innerText.replace(/,/g, '')) || 0;

    // 포인트 입력 필드 값을 현재 포인트로 설정
    document.getElementById('pointInput').value = pointCurrent.toLocaleString(); // 여기서 toLocaleString()를 추가했습니다.

    // 총 결제 금액에서 포인트 차감
    let amount = parseInt(document.getElementById('amount').innerText.replace(/,/g, '')) || 0;
    amount -= pointCurrent;

    // 포인트 차감 금액 업데이트
    document.getElementById('discount').innerText = pointCurrent.toLocaleString() + '원'; // 숫자를 쉼표 포함 문자열로 변환

    // 총 결제 금액 업데이트
    document.getElementById('amount').innerText = amount.toLocaleString();
});


/* 가지고 있는 포인트보다 많이 쓰려고 할 때, 음수 입력할 때 팝업창 + 0으로 초기화 (예라)*/
// 포인트 입력 필드 가져오기
const pointInput = document.getElementById('pointInput');

//사용자가 입력 필드에서 포커스를 잃었을 때 쉼표를 추가
pointInput.addEventListener('focusout', function() {
    let value = this.value.replace(/,/g, '');  // 쉼표 제거
    let pointValue = parseInt(value) || 0;
    this.value = pointValue.toLocaleString();  // 쉼표 추가
});

// 포인트 입력 값이 변경될 때마다 검사
pointInput.addEventListener('input', function() {
    // 입력된 값에서 쉼표를 제거
    let value = this.value.replace(/,/g, '');  
    
    // 숫자 이외의 문자가 입력되면 제거
    this.value = value.replace(/\D/g,'');

    // 현재 사용자의 포인트 가져오기
    let pointCurrent = parseInt(document.querySelector('.have-point-bold').innerText.replace(/,/g, '')) || 0;
    let pointValue = parseInt(this.value) || 0;
    
    // 입력된 포인트가 사용 가능한 포인트보다 큰지 검사
    if(pointValue > pointCurrent) {
        alert('사용 가능한 포인트보다 많이 입력하셨습니다.');
        this.value = '0';
        return;
    }
});



</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />