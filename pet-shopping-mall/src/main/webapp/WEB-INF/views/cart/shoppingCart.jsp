<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
	                	<sec:authentication property="principal" var="loginMember"/>
	                	<c:if test="${not empty cartList}">
		                	<c:forEach items="${cartList}" var="product" varStatus="vs">
		                	<fmt:formatNumber value='${(product.productPrice + product.additionalPrice) * product.quantity}' pattern="0,000" var="formattedPrice" />
		                	<div class="cart-product-info">
		                		<div class="product-thumbnail"><img src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}" width="110px"></div>
		                		<div>
		                			<div>
		                				<input type="checkbox" class="checkbox" name="productName" value="${formattedPrice}" cartitem-id="${product.cartitemId}">
		                				<label>${product.productName}</label>
		                			</div>
		                			<div> 
		                				<div id="cart-option">
		                					<div>
		                						<p>옵션 : ${product.optionName ne null ? product.optionName : '없음'}</p>
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
		                	<button id="cart-delete-btn" onclick="deleteCartOne('${product.cartitemId}');">✖</button>
		                	</div>
		                	<c:set var="totalPrice" value="${totalPrice + ((product.productPrice + product.additionalPrice) * product.quantity)}" />
		                	<form:form id="deleteOneFrm" method="POST" action="${pageContext.request.contextPath}/cart/deleteCartOne.do">
		                		<input type="hidden" name="cartitemId" value="">
		                	</form:form>
		                	</c:forEach>
		                </c:if>
		                <c:if test="${empty cartList}">
		                	<div class="cart-product-info">
		                		<p>장바구니에 담긴 상품이 없습니다.</p>
		                	</div>
		                </c:if>
		                <div>
		                	<button class="cart-btn" onclick="deleteAll();">전체 상품 삭제</button>
		                </div>
	                </div>
	                <div class="cart-right">
						<span>결제금액</span>
						<div class="payment-info">
							<div class="product-price">
								<fmt:formatNumber value='${totalPrice}' pattern="0,000" var="formattedTotal" />
								<strong class="price">결제 금액</strong>
								<p class="price" id="amount"></p>
							</div>
						</div>
						<div class="payment-info">
							<div>배송비와 쿠폰, 적립금이 미적용된 금액입니다.</div>
						</div>
						<c:choose>
						    <c:when test="${empty cartList}">
						        <script>
						            const payment = () => {
						                alert('장바구니에 담긴 상품이 없습니다.');
						                return;
						            };
						        </script>
						    </c:when>
						    <c:otherwise>
						        <script>
						            const payment = () => {
						                window.location.href = '${pageContext.request.contextPath}/payment/paymentInfo.do';
						            };
						        </script>
						    </c:otherwise>
						</c:choose>
						<div>
							<button class="btn btn1" id="order-btn" onclick="payment();">주문하기</button>
						</div>          
	                </div>
                </div>
            </div>
        </div>
	    <div id="modal">
	    	<div class="modal-div">
		    	<div id="modal-product-name"></div>
		    	<div>
		    		<img id="modal-img" scr="" style="width:90px"/>
		    	</div>
		    	<div class="quantity-container">
		    		수량
				    <button class="quantity-btn minus">-</button>
				    <input type="text" id="quantity" class="quantity-input" value="1">
				    <button class="quantity-btn plus">+</button>
				</div>
		    	<div>
		    	    <select id="modal-option" onchange="updateProduct(this);" style="width:250px">
		    	    	<option class="options" value="">옵션을 선택해주세요</option>
		    		</select>
		    	</div>
		    	<form:form id="updateFrm">
		    		<input type="hidden" value="" name="cartitemId" id="cartitemId" />
		    	</form:form>
		    	<div>
		    		💖수량 선택 후 옵션을 선택해주세요💖
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
                orderButton.classList.add('btncolor');
                return true;
            } else {
                orderButton.classList.remove('btncolor');
                return false;
            }
        });
    orderButton.disabled = !isChecked;
};

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

const formatPrice = (number) => {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
};

const deleteAll = () => {
	$("#deleteAllFrm").submit();
};

const deleteCartOne = (cartItemId) => {
    const frm = document.getElementById('deleteOneFrm');
    frm.cartitemId.value = cartItemId;
    frm.submit();
};


const modal = document.querySelector("#modal");
const openModalBtns = document.querySelectorAll(".update-btn");
const options = document.querySelector("#modal-option");
const updateFrm = document.querySelector("#updateFrm");
const cartitemIdInput = document.querySelector("#cartitemId");
const quantity = document.querySelector("#quantity");

openModalBtns.forEach(btn => {
    btn.addEventListener("click", () => {
    	const modalContent = document.querySelector("#modal-product-name");
        const productId = btn.getAttribute("product-id");
        const productDetailId = btn.getAttribute("product-detail-id");
        const img = document.querySelector("#modal-img");
        
        cartitemIdInput.value = btn.value;
        
        
     	$.ajax({
     		url: "${pageContext.request.contextPath}/cart/findProductOptionById.do?id=" + productId,
            method: 'GET',
            success(productInfo) {
                console.log(productInfo);
				productInfo.forEach((product) => {
                	modalContent.innerHTML = product.productName;
                	img.src = "${pageContext.request.contextPath}/resources/upload/product/"+ product.thumbnail;
					const optionName = product.optionName ? product.optionName : "옵션 없음";
					const optionValue = product.optionValue ? product.optionValue : " ";
					const addtionalPrice = product.additionalPrice ? "(+ " + product.additionalPrice + "원 )" : " ";
					options.innerHTML += `
							<option class="options" value="\${product.productDetailId}"> \${optionName} \${optionValue} \${addtionalPrice}</option>
					`;
				});
            }
    	});
        modal.style.display = "block";
        document.body.style.overflow = "hidden";
    });
});

const updateProduct = (product) => {
	const selectedOption = product.options[product.selectedIndex];
    const selectedValue = selectedOption.value;
    const updateQuantity = quantity.value;
    $.ajax({
        url: "${pageContext.request.contextPath}/cart/updateCart.do",
        method: "POST",
        data: {
        	memberId : "${loginMember.memberId}",
        	cartitemId : cartitemIdInput.value,
        	productDetailId : selectedValue,
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