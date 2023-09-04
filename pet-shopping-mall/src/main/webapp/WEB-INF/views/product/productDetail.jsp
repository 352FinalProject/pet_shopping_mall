<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<title>우리집동물친구[상품]</title>
<style>
   .heart-button {
      border: none;
        display: inline-block;
        font-size: 24px;
        cursor: pointer;
        background-color: white;
        
    }
    .pink {
        color: #ff8a9e;
    }

	.heart-img {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-right: -400px;
	margin-top: 3px;
</style>
<section class="common-section" id="#">
      <div class="common-container">
         <div class="product-div">
            <div class="product-img">
            <c:if test="${not empty thumbnailImages}">
               <img
                  src="${pageContext.request.contextPath}/resources/upload/product/${thumbnailImages[0].imageRenamedFilename}"
                  width="400px" />
            </c:if>
            </div>
            <div class="product-info">
               <div id="product-title">${product.productName}</div>
               <div class="product-assist">
                  <div id="price-info">
                     <fmt:formatNumber value="${product.productPrice}" pattern="#,###" />
                     원
                  </div>
                  <div class="product-assist">
                     <img
                        src="${pageContext.request.contextPath}/resources/images/상품/star.png"
                        alt="별점" />
                     <c:if test="${productReviewStarAvg.reviewStarRate == null}">
                        <span>0.0</span>
                        <span>&nbsp;|&nbsp;</span>
                     </c:if>
                     <c:if test="${productReviewStarAvg.reviewStarRate != null}">
                        <span>${productReviewStarAvg.reviewStarRate}</span>
                        <span>&nbsp;|&nbsp;</span>
                     </c:if>
                     <span><a href="#product-review-box">후기
                           ${reviewTotalCount}건</a></span>
                  </div>
               </div>
               <hr class="hr-line" />
               <!-- 적립금 -->
               <div class="won_img">
                  <img
                     src="${pageContext.request.contextPath}/resources/images/product/won.png"
                     width="30px" />
                  <div class="won_text">적립금</div>
               </div>
               <div class="won_desc">
                  구매 적립금 110원 <br /> 리뷰 적립금(텍스트) 500원 <br /> 리뷰 적립금(사진) 1,000원 <br />
               </div>
               <hr class="hr-line" />
               <!-- 배송 -->
               <div class="shipped_img">
                  <img
                     src="${pageContext.request.contextPath}/resources/images/product/shipped.png"
                     width="30px" />
                  <div class="shipped_text">배송</div>
               </div>
               <div class="shipped_desc">
                  배송비 3,000원(30,000원이상 구매시 무료배송) <br /> 오후 1시 이전 주문 시 오늘 출발 <br />
               </div>
               <hr class="hr-line" />
               <c:if test="${fn:length(productDetails) eq 1}">
                  <div class="purchase-cnt">
                     <div class="quantity-container">
                        <span>수량 </span>
                        <button class="quantity-btn minus">-</button>
                        <input type="text" id="quantity" class="quantity-input" value="1">
                        <button class="quantity-btn plus">+</button>
                     </div>
                  </div>
                  <div class="additional-price-container"
                     id="additional-price-container" style="display: none;">
                     <div class="additional-price"
                        id="${productDetails[0].productDetailId}">${productDetails[0].additionalPrice}</div>
                  </div>
               </c:if>
               <c:if test="${fn:length(productDetails) gt 1}">
                  <div>
                     <select name="product-option">
                        <c:forEach items="${productDetails}" var="productDetail"
                           varStatus="vs">
                           <c:if test="${empty productDetail.optionName}">
                              <option class="options"
                                 value="${productDetail.productDetailId}">[옵션 선택 안함]</option>
                           </c:if>
                           <c:if test="${not empty productDetail.optionName}">
                              <option class="options"
                                 value="${productDetail.productDetailId}">[${productDetail.optionName}]
                                 ${productDetail.optionValue} (+ ${productDetail.additionalPrice})</option>
                           </c:if>
                        </c:forEach>
                     </select>
                  </div>
                  <!-- 옵션추가금 -->
                  <div class="additional-price-container"
                     id="additional-price-container" style="display: none;">
                     <c:forEach items="${productDetails}" var="productDetail"
                        varStatus="vs">
                        <div class="additional-price"
                           id="${productDetail.productDetailId}">${productDetail.additionalPrice}</div>
                     </c:forEach>
                  </div>
                  <div class="purchase-cnt">
                     <div class="quantity-container">
                        <span>수량 </span>
                        <button class="quantity-btn minus">-</button>
                        <input type="text" id="quantity" class="quantity-input" value="1">
                        <button class="quantity-btn plus">+</button>
                     </div>
                  </div>
               </c:if>
   
               <div class="product-price">
                  <div class="product-price-desc">
                     총 상품 금액 <span class="totalPrice" id="totalPrice"></span>원
                  </div>
               </div>
            </div>
         </div>
    <!-- 상품 정보 -->
    <div class="bubble">
        <span>&nbsp;&nbsp;후기 작성하면 최대 1000원 지급!✨</span>
   </div>
    <div class="product-util-div">
      <ul class="product-utility">
        <li><a href="#">상품정보</a></li>
        <li><a href="#product-review-box">상품후기</a></li>
        <li><a href="#product-notice-box">교환/반품/배송</a></li>
        <li><a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionCreate.do">1:1문의</a></li>
      </ul>
    </div>
    
    <!-- 상세 페이지 -->
    <div class="common-container2" style="display: grid">
       <!-- 상세 이미지가 없다면 -->
       <c:if test="${empty detailImages}"></c:if>
       <!-- 상세 이미지가 있다면 -->
       <c:if test="${not empty detailImages}">
          <c:forEach items="${detailImages}" var="image" varStatus="vs">
             <div class="product-img">
                 <img
                   src="${pageContext.request.contextPath}/resources/upload/product/${image.imageRenamedFilename}"
                   width="500px" />
             </div>
          </c:forEach>
       </c:if>
      <div>
      </div>
    </div>
    </div>
   <!-- 상품 후기 -->
   <br>
   <div class="util-div" id="product-review-box">
      <ul class="product-utility">
         <li><a href="#">상품정보</a></li>
         <li><a href="#">상품후기</a></li>
         <li><a href="#">교환/반품/배송</a></li>
         <li><a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionCreate.do">1:1문의</a></li>
      </ul>
   </div>
   <div class="review-div">
      <ul class="review-product-utility">
         <c:if test="${empty reviews}"> 
           작성된 리뷰가 없습니다. 
           </c:if>
         <c:if test="${not empty reviews}">
         <div class="review-avg-star">
            <c:if test="${productReviewStarAvg.reviewStarRate == null}">
               <div>0.0</div>
               <div>☆☆☆☆☆</div> 
             </c:if>
            <c:if test="${productReviewStarAvg.reviewStarRate != null}">
                <div>${productReviewStarAvg.reviewStarRate}</div>
                <div class="review-avg-star2">
                 <c:choose>
                     <c:when test="${productReviewStarAvg.reviewStarRate >= 4.5}">★★★★★</c:when>
                     <c:when test="${productReviewStarAvg.reviewStarRate >= 3.5}">★★★★☆</c:when>
                     <c:when test="${productReviewStarAvg.reviewStarRate >= 2.5}">★★★☆☆</c:when>
                     <c:when test="${productReviewStarAvg.reviewStarRate >= 1.5}">★★☆☆☆</c:when>
                     <c:when test="${productReviewStarAvg.reviewStarRate >= 0.1}">★☆☆☆☆</c:when>
                     <c:otherwise>☆☆☆☆☆</c:otherwise>
                 </c:choose>
                </div>
            </c:if>
           </div>
           <div class="review-percent">
               <ul>
                <li>
                   <div class="star-label-and-progress">
                         <span class="star-label">1점</span>
                         <div class="progress">
                             <div class="progress-bar" style="width: ${formattedPercentages[1]}%;"></div>
                         </div>
                         <span class="percentage">${formattedPercentages[1]}%</span>
                         </div>
                </li>
                <li>
                   <div class="star-label-and-progress">
                         <span class="star-label">2점</span>
                         <div class="progress">
                             <div class="progress-bar" style="width: ${formattedPercentages[2]}%;"></div>
                         </div>
                         <span class="percentage">${formattedPercentages[2]}%</span>
                     </div>
                </li>
                <li>
                   <div class="star-label-and-progress">
                         <span class="star-label">3점</span>
                         <div class="progress">
                             <div class="progress-bar" style="width: ${formattedPercentages[3]}%;"></div>
                         </div>
                         <span class="percentage">${formattedPercentages[3]}%</span>
                     </div>
                </li>
                <li>
                   <div class="star-label-and-progress">
                         <span class="star-label">4점</span>
                         <div class="progress">
                             <div class="progress-bar" style="width: ${formattedPercentages[4]}%;"></div>
                         </div>
                         <span class="percentage">${formattedPercentages[4]}%</span>
                     </div>
                </li>
                <li>
                   <div class="star-label-and-progress">
                         <span class="star-label">5점</span>
                         <div class="progress">
                             <div class="progress-bar" style="width: ${formattedPercentages[5]}%;"></div>
                         </div>
                         <span class="percentage">${formattedPercentages[5]}%</span>
                     </div>
                </li>
            </ul>
         </div>                  
         <br><br>
         <div class="review-dividing-line"></div> <!-- 리뷰 시작 구분선 -->      
            <c:forEach items="${reviews}" var="review" varStatus="vs">
               <li>
                  <div class="review-box">
                     <div class="review-info-box">
                        <em class="review-info-id">${review.reviewMemberId}&nbsp;</em>
                        <!-- 리뷰 작성자 -->
                        <em class="review-info-date"> <!-- 작성일 --> 
                        <fmt:parseDate
                              value="${review.reviewCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm"
                              var="createdAt" /> <fmt:formatDate
                              value="${createdAt}" pattern="yyyy.MM.dd" 
                        />
                        </em>
                     </div>
                     <!-- 리뷰 펫 -->
                     <c:set var="pets" value="${reviewPetsMap[review.reviewId]}" />
                     <c:if test="${not empty pets}">
                        <div class="reivew-pet-box">
                           <!-- 펫정보 -->
                           <c:forEach items="${pets}" var="pet">
                              <em class="review-pet-name">${pet.petName} &nbsp;
                              <em class="review-em">|</em></em>
                              <em class="review-pet-gender">${pet.petGender} &nbsp;
                              <em class="review-em">|</em></em>
                              <em class="review-pet-age">${pet.petAge}살 &nbsp;
                              <em class="review-em">|</em></em>
                              <em class="review-pet-weight">${pet.petWeight}kg &nbsp;
                              <em class="review-em">|</em></em>
                              <em class="review-pet-breed">${pet.petBreed}</em>
                           </c:forEach>
                        </div>
                     </c:if>
                     <c:if test="${empty pets}">
	                      <em class="review-pet-name">펫 정보가 등록되지 않은 회원입니다.</em>
                     </c:if>
                     <!-- 리뷰 별점 -->
                     <c:set var="myReviewId" value="${review.reviewId}" />
                     <div class="review-detail-box">
                        <em class="review-info-title">${review.reviewTitle}</em>
                        <!-- 리뷰제목 -->
                        <div class="score_star">
                           <!-- 별점 -->
                           <c:choose>
                              <c:when test="${review.reviewStarRate == 1}">
                                 <span class="star-rating">★☆☆☆☆</span> (1.0)
                                     </c:when>
                              <c:when test="${review.reviewStarRate == 2}">
                                 <span class="star-rating">★★☆☆☆</span> (2.0)
                                     </c:when>
                              <c:when test="${review.reviewStarRate == 3}">
                                 <span class="star-rating">★★★☆☆</span> (3.0)
                                     </c:when>
                              <c:when test="${review.reviewStarRate == 4}">
                                 <span class="star-rating">★★★★☆</span> (4.0)
                                    </c:when>
                              <c:when test="${review.reviewStarRate == 5}">
                                 <span class="star-rating">★★★★★</span> (5.0)
                                     </c:when>
                                </c:choose>
                           </div>
                           <em class="review-info-content">${review.reviewContent}</em> <!-- 리뷰내용 -->
                           <span class="product-review-small-space"></span>
                          <!-- 리뷰 이미지 -->
								<div class="gallery_wrap3" style="height: 280px; margin-left:77px; margin-right:70px; margin-bottom: 27px;" >
									<ul class="gallery3">
										<c:set var="imageFilenames"
											value="${reviewImageMap[review.reviewId]}" />
										<c:if test="${not empty reviewImageMap[review.reviewId]}">
											<c:forEach var="filename"
												items="${reviewImageMap[review.reviewId]}" varStatus="loop">
												<li class="gallery_item1"><img class="indexImg"
													alt="Review Image"
													src="${pageContext.request.contextPath}/resources/upload/review/${filename}">
												</li>
											</c:forEach>
										</c:if>
									</ul>
								</div>
								<div class="button_box">
									<div class="prev_btn">
										<img style="margin-top:-151px"
											src="${pageContext.request.contextPath}/resources/images/home/left-arrow.png"
											alt="이전" />
									</div>
									<div class="next_btn">
										<img style="margin-top:-151px; margin-left:1100px;"
											src="${pageContext.request.contextPath}/resources/images/home/right-arrow.png"
											alt="다음" />
									</div>
								</div>
                         </div>
                       </div>
                     </li>
                      <c:if test="${vs.last}">	
                      <!-- 페이징 바 -->
				      <nav aria-label="..." class="product-review-paging"  style="display: flex; margin:0 auto;">
				        <ul class="pagination pagination-sm" style="margin-top: 10px">
				          <c:forEach begin="1" end="${totalPages}" var="pageNumber">
				            <li class="page-item ${page == pageNumber ? 'active' : ''}">
				              <a
				                class="page-link"
				                href="${pageContext.request.contextPath}/product/productDetail.do?productId=${product.productId}&page=${pageNumber}"
				              >
				                <span class="page-number">${pageNumber}</span>
				              </a>
				            </li>
				          </c:forEach>
				        </ul>
				      </nav>
                     </c:if>
                   </c:forEach>
                 </c:if>
               </ul>
             </div>
   <!-- 교환/반품/배송 -->
   <div class="util-div" id="product-notice-box" style="margin-top:1600px;"> 
      <ul class="product-utility">
         <li><a href="#">상품정보</a></li>
         <li><a href="#product-review-box">상품후기</a></li>
         <li><a href="#product-notice-box">교환/반품/배송</a></li>
         <li><a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionCreate.do">1:1문의</a></li>
      </ul>
   </div>
   <div class="processing-wrap">
      <span>1. 교환</span><br />
      <div class="change">
         - 상품 수령 후 7일 이내에 교환 가능합니다.<br /> - 교환을 원하는 상품은 반드시 동일 상품이어야 합니다. (색,
         사이즈 교환 가능)<br /> - 상품의 하자나 오배송으로 인한 경우 교환 배송비는 무료입니다.<br /> - 고객의
         단순 변심에 의한 교환의 경우 교환 배송비를 부담해야 합니다.<br />
         <br />
         <br />
      </div>
      <span>2. 반품</span><br />
      <div class="return">
         - 상품 수령 후 7일 이내에 반품 가능합니다.<br /> - 택을 제거했을 경우 반품이 불가능합니다.<br /> -
         고객의 단순 변심에 의한 경우 배송비는 고객이 부담해야 합니다.<br /> - 상품의 하자나 오배송으로 인한 반품의 경우
         반품 배송비는 무료입니다.<br />
         <br />
         <br />
      </div>
      <span>3. 환불</span><br />
      <div class="refund">
         - 상품 반품 시 환불 처리됩니다.<br /> - 반품 상품 접수 후 3~5일 이내에 환불이 완료됩니다.<br /> -
         환불은 원래 결제 수단으로 이루어집니다.<br />
         <br />
         <br />
      </div>
      <span>4. 절차</span><br />
      <div class="procedure">
         - 교환, 반품, 환불을 원하시는 경우 고객센터로 문의해주세요.<br /> - 교환, 반품, 환불 신청 시 주문번호와 상세
         사유를 함께 알려주세요.<br /> - 상품 수령 후 7일 이내에 가능하니 기간을 지켜주세요.<br /> - 제품의
         하자나 오배송 등의 사유로 인한 경우에는 추가적인 안내가 필요할 수 있습니다.<br />
         <br />
      </div>
   </div>
 	<div class="product-bottom">
		<div class="product-bottom2">
			<div class="product-bottom3">
				<span id="product-bottom-title" style="font-size: 15px;">${product.productName}</span>
				<br /> <span id="product-price" style="font-size: 15px; font-weight: 600;"> <fmt:formatNumber
						value="${product.productPrice}" pattern="#,###" /> 원
				</span>
			</div>
			<div class="heart-img" style="margin-top: -1px;">
				<button class="heart-button" id="heartButton">
					<span class="heart-button pink" id="clickHeart"> <c:choose>
							<c:when test="${likeState == 0}">♡</c:when>
							<c:otherwise>♥</c:otherwise>
						</c:choose>
					</span>
				</button>
				<span id="likeCnt">${product.likeCnt}</span>
			</div>
			<div class="cart-btn1" style="display:flex; gap: 10px;">
				<button class="btn btn1" style="margin:auto;" onclick="addCart();">장바구니</button>
				<button class="btn btn2" style="margin:auto;" onclick="purchase();">구매하기</button>
			</div>
		</div>
	</div>
   <form:form id="addCartFrm">
      <input type="hidden" value="1" id="_quantity" name="quantity">
      <input type="hidden" value="${productDetails[0].productDetailId}"
         id="_productDetailId" name="productDetailId">
   </form:form>

</section>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    let imgs = document.querySelector(".gallery3");
    createSlider(imgs);
});

function createSlider(imgs) {
    let img_count = imgs.childElementCount;
    let img_position = 0;
    
    imgs.parentNode.parentNode.querySelector(".prev_btn").addEventListener("click", function(e) {
        back();
    });

    imgs.parentNode.parentNode.querySelector(".next_btn").addEventListener("click", function(e) {
        if (img_position < img_count - 3) {
            next();
        } else {
            e.preventDefault();
        }
    });

    function back() {
        if (img_position > 0) {
            img_position--;
            imgs.style.transform = "translateX(" + (-img_position * 310) + "px)";
        }
    }

    function next() {
        if (img_position < img_count - 3) {
            img_position++;
            imgs.style.transform = "translateX(" + (-img_position * 310) + "px)";
        }
    }
}



// 상품 수량, 금액 조절
document.addEventListener("DOMContentLoaded", () => {
    const formatNumberWithCommas = (num) => {
        return num.toLocaleString('en-US');
    };

    const updatePrice = () => {
        const updateTotalPrice = (originalPrice + additionalPrice) * currentQuantity;
        if (totalPrice) {
            totalPrice.innerHTML = formatNumberWithCommas(updateTotalPrice);
        }
        if (productBottomPrice) {
            productBottomPrice.innerHTML = formatNumberWithCommas(updateTotalPrice);
        }
        if (productPriceElement) {
            productPriceElement.innerHTML = formatNumberWithCommas(updateTotalPrice);
        }
    };

    const optionSelect = document.querySelector("[name='product-option']");
    const originalPrice = parseInt('<c:out value="${product.productPrice}"/>');
    let additionalPrice = 0;
    const quantityInput = document.querySelector(".quantity-input");
    const totalPrice = document.querySelector("#totalPrice");
    const productBottomPrice = document.querySelector("#product-bottom-price");
    const optionMinusButton = document.querySelector(".minus");
    const optionPlusButton = document.querySelector(".plus");
    const productPriceElement = document.getElementById("product-price");
    
    let currentQuantity = parseInt(quantityInput.value) || 1;  // 수량이 지정되지 않은 경우 1로 설정

    // 상품디테일 아이디에 해당하는 추가금액
    if(optionSelect !== null){
       optionSelect.addEventListener("change", function() {
           const productDetailId = optionSelect.options[optionSelect.selectedIndex].value;
           const price = document.getElementById(productDetailId).innerHTML;
           document.getElementById('_productDetailId').value = productDetailId;
           document.getElementById('product-price').value = productPriceElement;
           if(price !== null) {
              additionalPrice = parseInt(price);
           }
           updatePrice();
       });
    }

    optionMinusButton.addEventListener("click", () => {
        if (currentQuantity > 1) {
            currentQuantity--;
            quantityInput.value = currentQuantity;
            document.getElementById('_quantity').value = currentQuantity;
        }
        updatePrice();
    });

    optionPlusButton.addEventListener("click", () => {
        currentQuantity++;
        quantityInput.value = currentQuantity;
        document.getElementById('_quantity').value = currentQuantity;
        updatePrice();
    });

    // 초기 총액 계산
    updatePrice();
});


// 장바구니에 담기 (담희)
function addCart() {
   const frm = document.querySelector("#addCartFrm");
   
   const quantityValue = frm.querySelector("#_quantity").value;
   const productDetailIdValue = frm.querySelector("#_productDetailId").value;
   
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/cart/insertCart.do",
        data: {
            quantity: quantityValue,
            productDetailId: productDetailIdValue
        },
        success(response) {
            alert(response.msg);
            if(confirm("장바구니로 이동하시겠습니까?")) {
               window.location.href = "${pageContext.request.contextPath}/cart/shoppingCart.do";
            }
        },
        error(error) {
          console.error(error);
        },
      }); 
};

function purchase() {
    if (confirm("정말 구매하시겠습니까?")) {
        const frm = document.querySelector("#addCartFrm");
        const productDetailIdValue = frm.querySelector("#_productDetailId").value;

        $.ajax({
            url: "${pageContext.request.contextPath}/cart/getCartList.do",
            method: "GET",
            success(cartList) {
                for (const product of cartList) {
                    if (product.productDetailId === productDetailIdValue) {
                        alert("이미 장바구니에 담겨있는 상품입니다.");
                        return;
                    }
                }
                frm.action = "${pageContext.request.contextPath}/payment/paymentInfo.do";
                frm.method = "POST";
                frm.submit();
            }
        });
    } else {
        alert("취소되었습니다.");
    }
};


/**
 * @author 강선모
 * 찜하기, 하트 클릭 이벤트
 */
let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");

$(function() {
    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
});
$("#clickHeart").on("click", function() {
    var state = $("#clickHeart").text().indexOf("♥") > -1 ? "delete" : "insert"; 
  
   
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/product/insertPick.do",
        dataType: "JSON",
        async: true,
        contentType: 'application/json',
        data: JSON.stringify({
            "productId": ${product.productId},
            "state": state
        }), 
        success: function(result) {
            if (result.rs == "insertS") { 
               $("#likeCnt").text(Number($("#likeCnt").text()) + 1); 
                $("#clickHeart").text("♥"); 
            } else if (result.rs == "deleteS") {
               $("#likeCnt").text(Number($("#likeCnt").text()) - 1);
                $("#clickHeart").text("♡"); 
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

<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   
<jsp:include page="/WEB-INF/views/common/pageUp.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />