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
					<c:choose>
						<c:when test="${not empty cartList}">
							<c:forEach items="${cartList}" var="product" varStatus="vs">
							<div class="cart-product-info">
								<c:set var="productTotal"
									value="${(product.productPrice + product.additionalPrice) * product.quantity}" />
								<c:set var="amount" value="${amount + productTotal}" />
								<div class="product-thumbnail">
									<img
										src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}"
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
								<input type="hidden" value="${product.productDetailId}"
									class="productDetailId" />
								<input type="hidden" value="${product.quantity}" class="quantity" />
							</form:form>
							</c:forEach>
						</c:when>
						<c:when test="${not empty purchaseOne}">
							<c:set value="${purchaseOne}" var="product"/>
							<div class="cart-product-info">
								<c:set var="productTotal"
									value="${(product.productPrice + product.additionalPrice) * product.quantity}" />
								<c:set var="amount" value="${amount + productTotal}" />
								<div class="product-thumbnail">
									<img
										src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}"
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
								<input type="hidden" value="${product.productDetailId}"
									class="productDetailId" />
								<input type="hidden" value="${product.quantity}" class="quantity" />
							</form:form>
						</c:when>
					</c:choose>
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
							<button class="cart-btn-update" onclick="updateDelivery();">수정</button>
						</div>
						<p id="">${loginMember.name}</p>
						<p id="phone">${loginMember.phone}</p>
						<p>
							<span id="address">${myPage.address}</span>
						</p>
					</div>
					<div>
						<p class="order-info-title">결제수단</p>
						<div>
							<label class="paybtn"> <input type="radio"
								name="paymethod" value="html5_inicis"> <span>카드결제</span>
							</label> 
							<label class="paybtn"> <input type="radio"
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
										style="width: 64px; text-align: right; margin-left: 10px;"> 원 
									<button type="button" class="discount-point-btn">사용</button>
									<button type="button" class="discount-point-btn">모두사용</button>
									<span class="have-point" style="margin-left: 5px;"> (보유
										<span class="have-point-bold" style="font-weight: 600"><fmt:formatNumber
												value="${pointCurrent}" groupingUsed="true" /></span>원 )
									</span>
									<div class="discount-coupon-info">
										<span class="discount-coupon">쿠폰</span> <select
											id="couponSelect">
											<option value="">쿠폰을 선택하세요</option>
										</select> <span class="have-point"> (보유 <span
											class="have-point-bold" style="font-weight: 600;">${couponCount}</span>장)
										</span>
									</div>
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
									<span>(+)</span><span id="deliveryFee">3,000</span>원
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
									<span style="color: red;">(-) <span id="couponDiscount">원</span></span>
								</p>
							</div>
						</div>
					</div>
					<div class="payment-info2">
						<div class="product-price">
							<strong class="price-title">최종 결제 금액</strong>
							<p class="price">
								<span id="amount"><fmt:formatNumber value="${amount + 3000}"
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
<form:form name="orderDeleteFrm" id="orderDeleteFrm" method="POST" action="${pageContext.request.contextPath}/order/deleteOrder.do">
	<input type="hidden" name="orderNo" value=""/>
	<input type="hidden" name="pointsUsed" value=""/>
	<input type="hidden" name="useCoupon" value=""/>
	<input type="hidden" name="couponId" value=""/>
</form:form>
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

let useCoupon = false;  // 쿠폰 사용 여부, 기본값은 false

// 쿠폰 선택 또는 다른 조건에 따라 useCoupon 값을 true로 설정
document.getElementById('couponSelect').addEventListener('change', function() {

  if (this.value !== "") {  // 쿠폰이 선택되면
    useCoupon = true;
  } else { // 쿠폰이 선택되지 않으면
    useCoupon = false;
  }
});

const proceedPay = () => {
    
	if (!checkAll.checked) {
        alert("이용약관에 동의해야 결제를 진행할 수 있습니다.");
        return; 
    }
    
	const checkedButton = document.querySelector('.paybtn input[type="radio"]:checked');
	
	let title;
	let cartListLength = ${fn:length(cartList)};

	if (cartListLength === 1) {
		title = "${cartList[0].productName}";
	} else if (cartListLength > 1) {
		title = "${cartList[0].productName}" +" 외" + (cartListLength - 1) + "개";
	} else {
		title ="${purchaseOne.productName}"
	}
	
	// 포인트 입력 값 가져오기 (예라)
    let pointValue = parseInt(document.getElementById('pointInput').value.replace(/,/g, '')) || 0;
	
	// 배송비 3000원 추가 (예라)
    let amountNumber = parseInt('${amount}'.replace(/,/g, ''));
    amountNumber += 3000;
    
    // 쿠폰 할인값 계산
    let enteredPoints = parseInt(document.getElementById('discount').innerText.replace(/,/g, '').replace('원', '')) || 0;
    let selectedCouponType = $('#couponSelect').find(':selected').data('type');
    let selectedCouponValue = $('#couponSelect').val();
    let totalPrice = parseInt($('#total-price').text().replace(/,/g, ''));
    let couponDiscount = 0;
    let pointsDiscount = enteredPoints;

    if (selectedCouponValue !== "") {
        if (selectedCouponType === '회원가입 배송비 무료 쿠폰') {
            couponDiscount = parseInt(document.getElementById('deliveryFee').innerText.replace(/,/g, ''));
        } else if (selectedCouponType === '생일축하 10% 할인 쿠폰') {
            couponDiscount = Math.floor((totalPrice - pointsDiscount) * 0.1);
        }
    }
    
	const memberRole = '${myPage.subscribe}';
	const delfee = (memberRole === 'Y' ? 0 : 3000);
	
	console.log("amountNumber:", amountNumber);
	console.log("pointValue:", pointValue);
	console.log("couponDiscount:", couponDiscount);
	
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
		deliveryFee: delfee,
		discount: pointValue + couponDiscount,
		couponId: $("#couponSelect").val(),
		amount: amountNumber - pointValue - couponDiscount,
		pointsUsed: pointValue,
		useCoupon: useCoupon,
		couponDiscount: couponDiscount,
		pg: checkedButton.value,
		
	};
	console.log(data);
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
	
 	$.ajax({
	    url: '${pageContext.request.contextPath}/payment/proceed.do',
	    type: 'POST',
	    async: true,
	    contentType:'application/json',
	    data : JSON.stringify(data),
	    success(response) {
	        console.log(response);
	        if(response.result > 0){
	            if(confirm("주문하시겠습니까?")) {
	                requestPaymentByCard(data);
	            } else {

	             // 포인트나 쿠폰을 사용했는지 확인
	                let dataToSend = { memberId: memberId };

	                if (pointValue > 0) {
	                    dataToSend.pointsUsed = pointValue;
	                }

	                if (useCoupon) {
	                    dataToSend.useCoupon = useCoupon;
	                }
	            
	                alert("주문이 취소되었습니다.");
	                const frm = document.querySelector("#orderDeleteFrm");
	                frm.orderNo.value = data.orderNo;
	                frm.pointsUsed.value = data.pointsUsed;
	                frm.useCoupon.value = data.useCoupon;
	                frm.couponId.value = data.couponId;
	                frm.submit();
	            }
	        }
	    }
	}); 
};

const requestPaymentByCard = (data) => {
	
	IMP.init('imp60204862');
	/* 2. 결제 데이터 정의 */
	IMP.request_pay({
		pg : data.pg,                         
    	pay_method: "card",
    	merchant_uid: data.orderNo,   
    	name: data.title,
    	amount: data.amount,                         
    	buyer_email: data.buyerEmail,
    	buyer_name: data.name,
    	buyer_tel: data.buyerTel,
    	buyer_addr: data.buyerAddr,
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
	            data: JSON.stringify(orderData), 
	            contentType: "application/json", 
	            dataType: "json", 
	        }).done((data) =>  {
	            alert("결제가 취소되었습니다.");
	        });
	        return;
	    } // if문 끝
	    
 		$.ajax({
			type: 'POST',
			url : '${pageContext.request.contextPath}/payment/verifyIamport/' + response.imp_uid,
		}).done((data) =>  {
			if(response.paid_amount == data.response.amount) {
				console.log(data);
				console.log(response);
				successPay(response.pg_provider, response.imp_uid, response.merchant_uid);
			}
		})
	});
}; 

const successPay = (pg_provider, imp_uid, merchant_uid) => {
	$.ajax({  
		 url : "${pageContext.request.contextPath}/payment/successPay.do",
		 type : "POST",
		 async : true,
		 dataType : "Json", 
		 data :{
			pg_provider: pg_provider,
			imp_uid: imp_uid,            // 결제 고유번호
         	merchant_uid: merchant_uid   // 주문번호 
		 },
		 success(data){
			if(data.result > 0){
           		location.href="${pageContext.request.contextPath}/payment/paymentCompleted.do?orderNo=" + merchant_uid;
            }else{
              	alert("결제 완료 되었으나 에러 발생하였습니다. 관리자에게 문의하세요.")
              	location.href="${pageContext.request.contextPath}/member/mypage.do"
		 	}
		 }
	});
};

//포인트 사용 버튼 클릭 시
document.querySelector('.discount-point-btn').addEventListener('click', function() {
    let pointValue = parseInt(document.getElementById('pointInput').value.replace(/,/g, '')) || 0;
    let amount = parseInt(document.getElementById('amount').innerText.replace(/,/g, '')) || 0;
    
    amount -= pointValue;
    
    if (pointValue > 0) {
        document.getElementById('discount').innerText = pointValue.toLocaleString() + '원';
    } else {
        document.getElementById('discount').innerText = '원';
    }

    document.getElementById('amount').innerText = amount.toLocaleString();
    
    updateFinalAmount();
});

// 모두 사용 버튼 클릭 시
document.querySelectorAll('.discount-point-btn')[1].addEventListener('click', function() {
    let pointCurrent = parseInt(document.querySelector('.have-point-bold').innerText.replace(/,/g, '')) || 0;

    document.getElementById('pointInput').value = pointCurrent.toLocaleString();

    let amount = parseInt(document.getElementById('amount').innerText.replace(/,/g, '')) || 0;
    amount -= pointCurrent;

    document.getElementById('discount').innerText = pointCurrent.toLocaleString() + '원';
    document.getElementById('amount').innerText = amount.toLocaleString();
    
    updateFinalAmount();
});

// 포인트 입력 필드 설정
const pointInput = document.getElementById('pointInput');

pointInput.addEventListener('focusout', function() {
    let value = this.value.replace(/,/g, '');
    let pointValue = parseInt(value) || 0;
    this.value = pointValue.toLocaleString();
});

pointInput.addEventListener('input', function() {
    let value = this.value.replace(/,/g, '');
    this.value = value.replace(/\D/g,'');
});

pointInput.addEventListener('input', function() {
    let value = this.value.replace(/,/g, '');
    this.value = value.replace(/\D/g,'');
    
    let pointCurrent = parseInt(document.querySelector('.have-point-bold').innerText.replace(/,/g, '')) || 0;
    let pointValue = parseInt(this.value) || 0;
    
    if (pointValue > pointCurrent) {
        alert('사용 가능한 포인트보다 많이 입력하셨습니다.');
        this.value = '0';
        return;
    }
});

// 쿠폰 데이터 드롭다운에 채우기
$.ajax({
    url: '${pageContext.request.contextPath}/payment/findCoupon.do',
    type: 'GET',
    dataType: 'json',
    success: function(response) {
        let $select = $('#couponSelect');
        $.each(response, function(index, coupon) {
            $select.append($('<option/>', { 
                value: coupon.couponId,
                text : coupon.couponName,
                'data-type': coupon.couponName
            }));
        });
    },
    error: function(error) {
        console.log("쿠폰 정보를 불러오는 데 실패했습니다.", error);
    }
});

// 최종 결제 금액 업데이트 함수
function updateFinalAmount() {
    
    // 쿠폰 할인값 계산
    let enteredPoints = parseInt(document.getElementById('discount').innerText.replace(/,/g, '').replace('원', '')) || 0;
    let selectedCouponType = $('#couponSelect').find(':selected').data('type');
    let selectedCouponValue = $('#couponSelect').val();
    let totalPrice = parseInt($('#total-price').text().replace(/,/g, ''));
    let deliveryFee = 3000;
    let couponDiscount = 0;
    let pointsDiscount = enteredPoints;

    if (selectedCouponValue !== "") {
        if (selectedCouponType === '회원가입 배송비 무료 쿠폰') {
            couponDiscount = deliveryFee;
        } else if (selectedCouponType === '생일축하 10% 할인 쿠폰') {
            couponDiscount = Math.floor((totalPrice - pointsDiscount) * 0.1);
        }
    }

    let finalAmount = totalPrice + deliveryFee - couponDiscount - pointsDiscount;
    $('#couponDiscount').text(couponDiscount.toLocaleString() + '원');
    $('#pointsDiscount').text(pointsDiscount.toLocaleString() + '원');
    $('#amount').text(finalAmount.toLocaleString());
}

// 쿠폰 선택 변경 시
$('#couponSelect').change(function() {
    updateFinalAmount();
});

// 포인트 입력 변경 시
$('#points').change(function() {
    updateFinalAmount();
});


const updateDelivery = () => {
	alert('수정을 위해 회원정보 수정 페이지로 넘어갑니다.');
	location.href="${pageContext.request.contextPath}/member/updateMember.do";
}

</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />