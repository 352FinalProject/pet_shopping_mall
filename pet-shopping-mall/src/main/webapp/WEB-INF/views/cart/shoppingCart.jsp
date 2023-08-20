<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <section class="common-section" id="#">
        <div class="common-title">
            장바구니
        </div>
        <div class="common-container">
            <div class="common-div">
            	<div class="shopping-div">
	                <div class="cart-left">
	                	<div>
	                		<input type="checkbox" name="checkAll" id="checkAll" class="checkbox" value="0">
	                		<label for="checkAll">전체 선택</label>
	                	</div>
	                	<c:if test="${not empty cartList}">
		                	<c:forEach items="${cartList}" var="product" varStatus="vs">
		                	<fmt:formatNumber value='${(product.productPrice + product.additionalPrice) * product.quantity}' pattern="0,000" var="formattedPrice" />
		                	<div class="cart-product-info">
		                		<div class="product-thumbnail"><img src="${pageContext.request.contextPath}/resources/images/product/sampleImg.jpg" width="110px"></div>
		                		<div>
		                			<div>
		                				<input type="checkbox" class="checkbox" name="productName" value="${formattedPrice}">
		                				<label>${product.productName}</label>
		                			</div>
		                			<div> 
		                				<div id="cart-option">
		                					<div>
		                						<p>옵션 : ${product.optionName}</p>
		                						<p>수량 : ${product.quantity}</p>
		                					</div>
		                					<div>
		                						<button class="cart-btn update-btn" value="${product.cartitemId}" product-id="${product.productId}" product-detail-id="${product.productDetailId}">옵션/수량변경</button>
		                					</div>
		                				</div>
		                				<div>
		                					<p>총 상품 금액 : <span class="target-price">${formattedPrice}</span>원</p>
		                				</div>
		                			</div>
		                		</div>
		                	</div>
		                	<c:set var="totalPrice" value="${totalPrice + ((product.productPrice + product.additionalPrice) * product.quantity)}" />
		                	<form:form id="deleteOneFrm" method="POST" action="${pageContext.request.contextPath}/cart/deleteCartOne.do">
		                		<input type="hidden" name="id" value="${product.cartitemId}">
		                	</form:form>
		                	</c:forEach>
		                </c:if>
		                <c:if test="${empty cartList}">
		                	<div class="cart-product-info">
		                		<p>장바구니에 담긴 상품이 없습니다.</p>
		                	</div>
		                </c:if>
	                	<div>
	                		<button class="cart-btn" onclick="deleteCartOne();">선택 상품 삭제</button>
	                		<button class="cart-btn" onclick="deleteAll();">전체 상품 삭제</button>
	                	</div>
	                </div>
	                <div class="cart-right">
						<span>결제금액</span>
						<div class="payment-info">
							<div>
								<div class="product-price">
									<span class="price"><strong>상품금액</strong></span>
									<p id="total-price"></p>
								</div>
								<div class="product-price">
									<span>배송비</span>
									<p><span>(+)</span>3,000원</p>
								</div>
								<div class="product-price">
									<span>사용 가능 적립금</span>
									<fmt:formatNumber value='${pointCurrent}' pattern="0,000" var="formattedPoint" />
									<p id="point"><span>(-)</span>${formattedPoint}원</p>
								</div>
							</div>
						</div>
						<div class="payment-info">
							<div class="product-price">
								<fmt:formatNumber value='${totalPrice}' pattern="0,000" var="formattedTotal" />
								<strong class="price">최종 결제 금액</strong>
								<p class="price" id="amount"></p>
							</div>
						</div>
						<div>
							<button class="btn btn1" id="order-btn" onclick="payment();">주문하기</button>
						</div>          
	                </div>
                </div>
            </div>
        </div>
	    <div id="modal">
	    	<div class="modal-div">
		    	<div id="modal-content"></div>
		    	<div class="quantity-container">
		    		수량
				    <button class="quantity-btn minus">-</button>
				    <input type="text" id="quantity" class="quantity-input" value="1">
				    <button class="quantity-btn plus">+</button>
				</div>
		    	<div>
		    		옵션변경
		    	    <select id="modal-option" onchange="updateProduct(this);">
		    	    	<option>옵션을 선택해주세요</option>
		    		</select>
		    	</div>
		    	<form:form id="updateFrm">
		    		<input type="hidden" value="" name="cartitemId" id="cartitemId" />
		    	</form:form>
		    	<div>
		    		<button id="close-modal">완료</button>
		    	</div>
	    	</div>
	   	</div>
    </section>
<form:form id="deleteAllFrm" method="POST" 
	action="${pageContext.request.contextPath}/cart/deleteCartAll.do">
</form:form>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");

$(function() {
    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
});

const productNameCheckboxes = document.querySelectorAll('input[name="productName"]');
const orderButton = document.getElementById("order-btn");
const checkAll = document.querySelector("#checkAll");
const checkboxes = document.querySelectorAll('.checkbox');

 // 모든 체크박스

checkAll.addEventListener("change", () => {
    const isChecked = checkAll.checked;
    productNameCheckboxes.forEach(checkbox => {
        checkbox.checked = isChecked;
    });
});

checkboxes.forEach(checkbox => {
    checkbox.addEventListener('change', updateSubmitButtonStatus);
    checkbox.addEventListener('change', updatePrice);
});

function updateSubmitButtonStatus() {
	
    const isChecked = Array.from(checkboxes)
        .some(checkbox => {
            if (checkbox.checked) {
                orderButton.classList.add('active');
                return true;
            } else {
                orderButton.classList.remove('active');
                return false;
            }
        });
    orderButton.disabled = !isChecked;
}

function updatePrice () {
	let total = 0;
	checkboxes.forEach(box => {
        if (box.checked) {
            let p = Number(box.value.replace(",", ""));
            total += p;
        }
    });
    
	document.querySelector("#amount").innerHTML = formatPrice(total);
}

const payment = () => {
	window.location.href = '${pageContext.request.contextPath}/payment/paymentInfo.do';
};

const formatPrice = (number) => {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
};

const deleteAll = () => {
	$("#deleteAllFrm").submit();
};

const deleteCartOne = () => {
	$("#deleteOneFrm").submit();
};


const modal = document.querySelector("#modal");
const openModalBtns = document.querySelectorAll(".update-btn");
const closeModalBtn = document.querySelector("#close-modal");
const modalContent = document.querySelector("#modal-content");
const options = document.querySelector("#modal-option");
const updateFrm = document.querySelector("#updateFrm");
const cartitemIdInput = document.querySelector("#cartitemId");
const quantity = document.querySelector("#quantity");

openModalBtns.forEach(btn => {
    btn.addEventListener("click", () => {
        const productId = btn.getAttribute("product-id");
        const productDetailId = btn.getAttribute("product-detail-id");
        cartitemIdInput.value = btn.value;
        
     	$.ajax({
    		url: "${pageContext.request.contextPath}/cart/findProdById.do?id=" + productId,
			method: 'GET',
			success(products) {
				console.log(products);
				products.forEach((product) => {
					modalContent.innerHTML = `
	                    <h2>\${product.productName}</h2>
	                `;
					options.innerHTML += `
						<option value="\${product.productDetailId}"> \${product.optionName} \${product.optionValue}</option>
					`;
				});
			}
    	});
        modal.style.display = "block";
        document.body.style.overflow = "hidden";
        
    });
});

closeModalBtn.addEventListener("click", () => {
	
	modal.style.display = "none";
    document.body.style.overflow = "auto";
	options.innerHTML = ''; // 초기화
});

const updateProduct = (product) => {
	const selectedOption = product.options[product.selectedIndex];
    const selectedValue = selectedOption.value;
    const updateQuantity = quantity.value;
    $.ajax({
        url: "${pageContext.request.contextPath}/cart/updateCart.do",
        method: "POST",
        data: {
        	cartitemId : cartitemIdInput.value,
            selectedValue: selectedValue,
            quantity : updateQuantity
        },
        success(response) {
            alert('변경 완료!');
            location.href="${pageContext.request.contextPath}/cart/shoppingCart.do"
        }
    });
};

const quantityContainer = document.querySelector('.quantity-container');
const quantityInput = quantityContainer.querySelector('.quantity-input');
const minusButton = quantityContainer.querySelector('.minus');
const plusButton = quantityContainer.querySelector('.plus');

minusButton.addEventListener('click', () => {
    let currentValue = parseInt(quantityInput.value);
    if (currentValue > 1) {
        currentValue--;
        quantityInput.value = currentValue;
    }
});

plusButton.addEventListener('click', () => {
    let currentValue = parseInt(quantityInput.value);
    currentValue++;
    quantityInput.value = currentValue;
});

</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>