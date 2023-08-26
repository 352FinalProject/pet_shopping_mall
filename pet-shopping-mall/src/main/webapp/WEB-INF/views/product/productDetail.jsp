<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ pageisELIgnored="false" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<title>우리집동물친구[상품]</title>
<!-- Bootstrap CSS 포함 -->
<link
  rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
/>

<style>
	.heart-button {
        display: inline-block;
        font-size: 24px;
        color: black; /* 검은색 하트의 기본 색상 */
        cursor: pointer;
    }
    
    .pink {
        color: pink; /* 핑크색 하트 */
    }
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<section class="common-section" id="#">
  <div class="common-container">
    <div class="product-div">
      <div class="product-img">
        <img
          src="${pageContext.request.contextPath}/resources/upload/product/${productImages.attachments[0].imageRenamedFilename}"
          width="400px"
        />
      </div>
      <div class="product-info">
        <div id="product-title">${product.productName}</div>
        <div class="product-assist">
          <div id="price-info"><fmt:formatNumber value="${product.productPrice}" pattern="#,###" />원</div>
          <div class="product-assist">
            <img
              src="${pageContext.request.contextPath}/resources/images/상품/star.png"
              alt="별점"
            /><span>5.0</span> <span>&nbsp;|&nbsp;</span>
            <span><a href="#">후기 102건</a></span>
          </div>
        </div>
        <hr class="hr-line" />
        <!-- 적립금 -->
        <div class="won_img">
          <img
            src="${pageContext.request.contextPath}/resources/images/product/won.png"
            width="30px"
          />
          <div class="won_text">적립금</div>
        </div>
        <div class="won_desc">
          구매 적립금 110원 <br />
          리뷰 적립금(텍스트) 500원 <br />
          리뷰 적립금(사진) 1,000원 <br />
        </div>
        <hr class="hr-line" />
        <!-- 배송 -->
        <div class="shipped_img">
          <img
            src="${pageContext.request.contextPath}/resources/images/product/shipped.png"
            width="30px"
          />
          <div class="shipped_text">배송</div>
        </div>
        <div class="shipped_desc">
          배송비 3,000원(30,000원이상 구매시 무료배송) <br />
          오후 1시 이전 주문 시 오늘 출발 <br />
        </div>
        <hr class="hr-line" />
        <!-- 선택 옵션 -->
        <!-- 옵션 없을 때 -->
        <c:if test="${empty productDetails}">
        	<!-- 상품구입 개수 입력 -->
        	<div class="purchase-cnt">
		    	<div class="quantity-container">
		    		<spna>수량  </spna>
				    <button class="quantity-btn minus">-</button>
				    <input type="text" id="quantity" class="quantity-input" value="1">
				    <button class="quantity-btn plus">+</button>
				</div>
        	</div>
        	
        </c:if>
        <!-- 옵션 있을 때 -->
        <c:if test="${not empty productDetails}">
	        <div>
	          <select name="product-option">
	            <option value="">[필수]옵션선택</option>
	            <!-- 옵션나열 -->
	        	<c:forEach items="${productDetails}" var="productDetail" varStatus="vs">
	        		<c:if test="${empty productDetail.optionName}">
	            		<option value="${productDetail.productDetailId}">[옵션없음]</option>
	        		</c:if>
	        		<c:if test="${not empty productDetail.optionName}">
	            		<option value="${productDetail.productDetailId}">[${productDetail.optionName}] ${productDetail.optionValue}</option>
	        		</c:if>
	        	</c:forEach>
	          </select>
	        </div>
	        
            	<!-- 상품구입 개수 입력 -->
        	<div class="purchase-cnt">
		    	<div class="quantity-container">
		    		<spna>수량  </spna>
				    <button class="quantity-btn minus">-</button>
				    <input type="text" id="quantity" class="quantity-input" value="1">
				    <button class="quantity-btn plus">+</button>
				</div>
        	</div>
	        
        </c:if>
        
        
        
        <div class="product-price">
          <div class="product-price-desc">
            총 상품 금액 <span><fmt:formatNumber value="${product.productPrice}" pattern="#,###" /></span>원
          </div>
        </div>
      </div>
    </div>
    <!-- 상품 정보 -->
    <div class="util-div">
      <ul class="product-utility">
        <li><a href="#">상품정보</a></li>
        <li><a href="#product-review-box">상품후기</a></li>
        <li><a href="#product-notice-box">교환/반품/배송</a></li>
        <li><a href="#">1:1문의</a></li>
      </ul>
    </div>
    <!-- 상세 페이지 -->
    <div class="common-container2">
      <div>
        <img
          src="${pageContext.request.contextPath}/resources/images/1690801774638.jpg"
          width="500px"
        />
      </div>
    </div>
    </div>
    <br>
    <!-- 상품 후기 -->
     <br><div class="util-div" id="product-review-box">
      <ul class="product-utility" >
        <li><a href="#">상품정보</a></li>
        <li><a href="#">상품후기</a></li>
        <li><a href="#">교환/반품/배송</a></li>
        <li><a href="#">1:1문의</a></li>
      </ul>
    </div>
    <div class="review-div" > 
      <ul class="review-product-utility">
        <c:if test="${empty reviews}"> 
        	작성된 리뷰가 없습니다. 
        </c:if>
        <c:if test="${not empty reviews}">
          <c:forEach items="${reviews}" var="review" varStatus="vs">
            <li>
              <div class="review-box">
                <div class="review-info-box">
                  <em class="review-info-id">${review.reviewMemberId}</em> <!-- 리뷰 작성자 -->
                  <em class="review-info-date"> <!-- 작성일 -->
                    <fmt:parseDate
                      value="${review.reviewCreatedAt}"
                      pattern="yyyy-MM-dd'T'HH:mm"
                      var="createdAt"
                    />
                    <fmt:formatDate value="${createdAt}" pattern="yyyy.MM.dd" />
                  </em>
                </div>
                <c:set var="pets" value="${reviewPetsMap[review.reviewId]}" />
                <c:if test="${not empty pets}">
                  <div class="reivew-pet-box"> <!-- 펫정보 -->
                    <c:forEach items="${pets}" var="pet">
                      <em class="review-pet-name">${pet.petName} |</em>
                      <em class="review-pet-name">${pet.petGender} |</em>
                      <em class="review-pet-name">${pet.petAge}살 |</em>
                      <em class="review-pet-name">${pet.petWeight}kg |</em>
                      <em class="review-pet-name">${pet.petBreed}</em>
                    </c:forEach>
                  </div>
                </c:if>
                <c:set var="myReviewId" value="${review.reviewId}" />
                <div class="review-detail-box">
	                  <em class="review-info-id">${review.reviewTitle}</em> <!-- 리뷰제목 -->
	                  <div class="score_star"> <!-- 별점 -->
	                    <c:choose>
	                      <c:when test="${review.reviewStarRate == 1}">
	                        <span class="star-rating">★☆☆☆☆</span> (1)
	                      </c:when>
	                      <c:when test="${review.reviewStarRate == 2}">
	                        <span class="star-rating">★★☆☆☆</span> (2)
	                      </c:when>
	                      <c:when test="${review.reviewStarRate == 3}">
	                        <span class="star-rating">★★★☆☆</span> (3)
	                      </c:when>
	                      <c:when test="${review.reviewStarRate == 4}">
	                        <span class="star-rating">★★★★☆</span> (4)
	                      </c:when>
	                      <c:when test="${review.reviewStarRate == 5}">
	                        <span class="star-rating">★★★★★</span> (5)
	                      </c:when>
	                    </c:choose>
	                  </div>
	                  <em class="review-info-id">${review.reviewContent}</em> <!-- 리뷰내용 -->
						<!-- 리뷰 이미지 -->
						<c:if test="${not empty reviewImageMap[review.reviewId]}"> 
						  <div class="review-warp">
						    <div class="detail-upload">
						      <img src="${pageContext.request.contextPath}/resources/upload/review/${reviewImageMap[review.reviewId]}" 
						        alt="Review Image">
						    </div>
						  </div>
						</c:if>
				  </div>
                </div>
            </li>
      	</c:forEach>
      </c:if>
   </ul>
</div>
<!-- 페이징 바 -->
<nav aria-label="..." class="product-review-paging">
  <ul class="pagination pagination-sm">
    <c:forEach begin="1" end="${totalPages}" var="pageNumber">
      <li class="page-item ${page == pageNumber ? 'active' : ''}">
        <a
          class="page-link"
          href="${pageContext.request.contextPath}/product/productDetail.do?page=${pageNumber}"
        >
          <span class="page-number">${pageNumber}</span>
        </a>
      </li>
    </c:forEach>
  </ul>
</nav>

    <!-- 교환/반품/배송 -->
    <div class="util-div" id="product-notice-box">
      <ul class="product-utility" >
        <li><a href="#">상품정보</a></li>
        <li><a href="#product-review-box">상품후기</a></li>
        <li><a href="#product-notice-box">교환/반품/배송</a></li>
        <li><a href="#">1:1문의</a></li>
      </ul>
    </div>
    <div class="processing-wrap">
      <span>1. 교환</span><br />
      <div class="change">
        - 상품 수령 후 7일 이내에 교환 가능합니다.<br />
        - 교환을 원하는 상품은 반드시 동일 상품이어야 합니다. (색, 사이즈 교환
        가능)<br />
        - 상품의 하자나 오배송으로 인한 경우 교환 배송비는 무료입니다.<br />
        - 고객의 단순 변심에 의한 교환의 경우 교환 배송비를 부담해야 합니다.<br /><br /><br />
      </div>
      <span>2. 반품</span><br />
      <div class="return">
        - 상품 수령 후 7일 이내에 반품 가능합니다.<br />
        - 택을 제거했을 경우 반품이 불가능합니다.<br />
        - 고객의 단순 변심에 의한 경우 배송비는 고객이 부담해야 합니다.<br />
        - 상품의 하자나 오배송으로 인한 반품의 경우 반품 배송비는 무료입니다.<br /><br /><br />
      </div>
      <span>3. 환불</span><br />
      <div class="refund">
        - 상품 반품 시 환불 처리됩니다.<br />
        - 반품 상품 접수 후 3~5일 이내에 환불이 완료됩니다.<br />
        - 환불은 원래 결제 수단으로 이루어집니다.<br /><br /><br />
      </div>
      <span>4. 절차</span><br />
      <div class="procedure">
        - 교환, 반품, 환불을 원하시는 경우 고객센터로 문의해주세요.<br />
        - 교환, 반품, 환불 신청 시 주문번호와 상세 사유를 함께 알려주세요.<br />
        - 상품 수령 후 7일 이내에 가능하니 기간을 지켜주세요.<br />
        - 제품의 하자나 오배송 등의 사유로 인한 경우에는 추가적인 안내가 필요할
        수 있습니다.<br /><br />
      </div>
    </div>
  </div>
  <div class="product-bottom">
    <div class="product-bottom2">
      <div>
        <span id="product-bottom-title" style="font-size: 24px;">${product.productName}</span> <br />
        <span style="font-size: 18px; font-weight: 600;">
        	<fmt:formatNumber value="${product.productPrice}" pattern="#,###" /> 원
        </span>
      </div>
      <div class="heart-img">
        <button class="heart-button" id="heartButton">
        	<c:choose>
        		<c:when test="${likeState == 0}">
					<span class="heart-button" id="clickHeart">♡</span>
				</c:when>
				<c:otherwise>
					<span class="heart-button pink" id="clickHeart">♥</span>
					
				</c:otherwise>
			</c:choose>
        </button>
        <span id="likeCnt">${product.likeCnt}</span>
      </div>
      <div>
        <button class="btn btn1">장바구니</button>
        <button class="btn btn2">구매하기</button>
      </div>
    </div>
  </div>
</section>
<script>
/* 상품수량에 따라 가격 바꾸기(수경) */

document.addEventListener("DOMContentLoaded", function () {
  const optionSelect = document.querySelector("select[name='product-option']");
  const quantityInput = document.querySelector(".quantity-input");
  const optionMinusButton = document.querySelector(".minus");
  const optionPlusButton = document.querySelector(".plus");
  const addToCartButton = document.querySelector(".btn1"); // 장바구니 버튼 선택

  let currentQuantity = 1;

  optionMinusButton.addEventListener("click", () => {
    if (currentQuantity > 1) {
      currentQuantity--;
      quantityInput.value = currentQuantity;
    }
  });

  optionPlusButton.addEventListener("click", () => {
    currentQuantity++;
    quantityInput.value = currentQuantity;
  });

  addToCartButton.addEventListener("click", () => {
    const selectedOptionId = optionSelect.value;
    
    // URL에서 파라미터 값을 가져오기
    const urlParams = new URLSearchParams(window.location.search);
    const productId = urlParams.get("productId"); // 상품 id 가져오기
    const quantity = currentQuantity;

    // 장바구니에 상품 추가
    $.ajax({
      type: "POST",
      url: "${pageContext.request.contextPath}/cart/shoppingCart.do",
      data: {
    	productDetailId: productId,
        optionId: selectedOptionId,
        quantity: quantity,
      },
      success: function (response) {
    	alert("상품이 추가되었습니다.");
      },
      error: function (error) {
        console.error(error);
      },
    });
  });
});


  // 리뷰 페이지 아코디언 효과
  /* const ques = document.querySelectorAll(".que");
const anws = document.querySelectorAll(".anw");

ques.forEach(que => {
  que.addEventListener("click", function() {
    const currentAnw = this.nextElementSibling;
    
    // 다른 질문들에 있는 'on' 클래스 제거
    ques.forEach(item => {
      if (item !== this) {
        item.classList.remove('on');
      }
    });
    
    // 현재 질문에 'on' 클래스 토글
    this.classList.toggle('on');
    
    // 현재 질문의 답변 토글
    currentAnw.style.display = currentAnw.style.display === 'block' ? 'none' : 'block';
    
    // 다른 답변들 닫기
    anws.forEach(anw => {
      if (anw !== currentAnw && anw.style.display === 'block') {
        anw.style.display = 'none';
      }
    });
  });
}); */

	// 하트 클릭 이벤트 (선모)
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
	$(function() {
	    $(document).ajaxSend(function(e, xhr, options) {
	        xhr.setRequestHeader(header, token);
	    });
	});
	
	$("#clickHeart").on("click", function() {
		var state = $(this).hasClass("pink") ? "delete" : "insert";
		
		$.ajax({
			type: "POST",
			url: "${pageContext.request.contextPath}/product/insertPick.do",
			dataType: "JSON",
			async: true,
			contentType:'application/json',
			data: JSON.stringify({
				"productId": ${product.productId},
				"state": state
			}),
			success: function(result) {
				if(result.rs == "insertS") {
					$("#clickHeart").addClass("pink");
					$("#likeCnt").text(Number($("#likeCnt").text()) + 1);
				} else if(result.rs == "deleteS") {
					$("#clickHeart").removeClass("pink");
					$("#likeCnt").text(Number($("#likeCnt").text()) - 1);
				}
				
				alert(result.msg);
			},
			error: function(req, status, error) {
				alert("에러가 발생하였습니다.");
				console.log(req.responseText);
			}
		});	
	});
</script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
