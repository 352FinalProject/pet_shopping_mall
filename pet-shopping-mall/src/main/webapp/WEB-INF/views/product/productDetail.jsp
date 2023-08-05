<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<section class="common-section" id="#">
	<div class="common-container">
		<div class="product-div">
			<div class="product-img">
				<img
					src="${pageContext.request.contextPath}/resources/images/product/sampleImg.jpg"
					width=400px />
			</div>
			<div class="product-info">
				<div id="product-title">이탈리아에서 찍은 어떤 고양이 귀엽죠</div>
				<div class="product-assist">
					<div id="price-info">11,000원</div>
					<div class="product-assist">
						<img src="${pageContext.request.contextPath}/resources/images/상품/star.png" alt="별점" ><span>5.0</span> <span>&nbsp;|&nbsp;</span> <span><a
							href="#">후기 102건</a></span>
					</div>
				</div>
				<hr class="hr-line">
				<!-- 적립금 -->
				<div class="won_img">
					<img
						src="${pageContext.request.contextPath}/resources/images/product/won.png"
						width="30px">
					<div class="won_text">적립금</div>
				</div>
				<div class="won_desc">
					구매 적립금 110원 <br /> 리뷰 적립금(텍스트) 500원 <br /> 리뷰 적립금(사진) 1,000원 <br />
				</div>
				<hr class="hr-line">
				<!-- 배송 -->
				<div class="shipped_img">
					<img
						src="${pageContext.request.contextPath}/resources/images/product/shipped.png"
						width="30px">
					<div class="shipped_text">배송</div>
				</div>
				<div class="shipped_desc">
					배송비 3,000원(30,000원이상 구매시 무료배송) <br /> 오후 1시 이전 주문 시 오늘 출발 <br />
				</div>
				<hr class="hr-line">
				<!-- 선택 옵션 -->
				<div>
					<select name="product-option">
						<option value=''>[필수]옵션선택</option>
						<option value=''>귀여워요</option>
					</select>
				</div>
				<div class="product-price">
					<div class="product-price-desc">
						총 상품 금액 <span>11,000</span>원
					</div>
				</div>
			</div>
		</div>
		<!-- 상품 정보 -->
		<div class="util-div">
			<ul class="product-utility">
				<li><a href="#">상품정보</a></li>
				<li><a href="#">상품후기</a></li>
				<li><a href="#">교환/반품/배송</a></li>
				<li><a href="#">1:1문의</a></li>
			</ul>
		</div>
		<!-- 상세 페이지 -->
		<div class="common-container2">
			<div>
				<img
					src="${pageContext.request.contextPath}/resources/images/1690801774638.jpg"
					width=500px>
			</div>
		</div>
		<!-- 상품 후기 -->
		<div class="util-div">
			<ul class="product-utility">
				<li><a href="#">상품정보</a></li>
				<li><a href="#">상품후기</a></li>
				<li><a href="#">교환/반품/배송</a></li>
				<li><a href="#">1:1문의</a></li>
			</ul>
		</div>
		<div id="Accordion_wrap">
			<div class="que">
				<div class="score_star"><img src="${pageContext.request.contextPath}/resources/images/상품/star.png" alt="별점"><span class="star_test">5.0</span></div>
				<span>너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ </span>
				<div class="review-warp">
					<span class="review-name">호두누나</span>
				</div>
				<div class="review-data-wrap">
					<span class="review-data">23.08.06</span>
				</div>
			</div>
			<div class="anw">
				<div class="review-profile">호두누나 <span>2023.08.06 <br/>
				호두 | 수컷 | 3살 | 5.7kg | 푸숑</span> </div>
				<img src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg" alt="리뷰사진">
				<div class="review-desc">너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 
				<br/> 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~</div>
			</div>
			<div class="que">
				<div class="score_star"><img src="${pageContext.request.contextPath}/resources/images/상품/star.png" alt="별점"><span class="star_test">5.0</span></div>
				<span>너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ </span>
				<div class="review-warp">
					<span class="review-name">몽이쥔</span>
				</div>
				<div class="review-data-wrap">
					<span class="review-data">23.08.06</span>
				</div>
			</div>
			<div class="anw">
				<div class="review-profile">몽이쥔 <span>2023.08.06 <br/>
				몽이 | 수컷 | 3살 | 5.7kg | 요크셔테리어</span> </div>
				<img src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg" alt="리뷰사진">
				<div class="review-desc">너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 
				<br/> 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~</div>
			</div>
			<div class="que">
				<div class="score_star"><img src="${pageContext.request.contextPath}/resources/images/상품/star.png" alt="별점"><span class="star_test">5.0</span></div>
				<span>너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ </span>
				<div class="review-warp">
					<span class="review-name">두부누나</span>
				</div>
				<div class="review-data-wrap">
					<span class="review-data">23.08.06</span>
				</div>
			</div>
			<div class="anw">
				<div class="review-profile">두부누나 <span>2023.08.06 <br/>
				두부 | 수컷 | 3살 | 5.7kg | 비숑프리제</span> </div>
				<img src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg" alt="리뷰사진">
				<div class="review-desc">너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 
				<br/> 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~</div>
			</div>
		</div>
		<!-- 교환/반품/배송 -->
		<div class="util-div">
			<ul class="product-utility">
				<li><a href="#">상품정보</a></li>
				<li><a href="#">상품후기</a></li>
				<li><a href="#">교환/반품/배송</a></li>
				<li><a href="#">1:1문의</a></li>
			</ul>
		</div>
		<div class="processing-wrap">
				<span>1. 교환</span><br/>
				<div class="change">
				- 상품 수령 후 7일 이내에 교환 가능합니다.<br/>
				- 교환을 원하는 상품은 반드시 동일 상품이어야 합니다. (색, 사이즈 교환 가능)<br/>
				- 상품의 하자나 오배송으로 인한 경우 교환 배송비는 무료입니다.<br/>
				- 고객의 단순 변심에 의한 교환의 경우 교환 배송비를 부담해야 합니다.<br/><br/><br/>
			</div>
				<span>2. 반품</span><br/>
				<div class="return">
				- 상품 수령 후 7일 이내에 반품 가능합니다.<br/>
				- 택을 제거했을 경우 반품이 불가능합니다.<br/>
				- 고객의 단순 변심에 의한 경우 배송비는 고객이 부담해야 합니다.<br/>
				- 상품의 하자나 오배송으로 인한 반품의 경우 반품 배송비는 무료입니다.<br/><br/><br/>
			</div>
				<span>3. 환불</span><br/>
				<div class="refund">
				- 상품 반품 시 환불 처리됩니다.<br/>
				- 반품 상품 접수 후 3~5일 이내에 환불이 완료됩니다.<br/>
				- 환불은 원래 결제 수단으로 이루어집니다.<br/><br/><br/>
			</div>
				<span>4. 절차</span><br/>
				<div class="procedure">
				- 교환, 반품, 환불을 원하시는 경우 고객센터로 문의해주세요.<br/>
				- 교환, 반품, 환불 신청 시 주문번호와 상세 사유를 함께 알려주세요.<br/>
				- 상품 수령 후 7일 이내에 가능하니 기간을 지켜주세요.<br/>
				- 제품의 하자나 오배송 등의 사유로 인한 경우에는 추가적인 안내가 필요할 수 있습니다.<br/><br/>
			</div>
		</div>
	</div>
	<div class="product-bottom">
		<div class="product-bottom2">
			<div>
				<span id="product-bottom-title">제품명 나오는 곳</span> <br /> <span>11,000원</span>
			</div>
			<div class="heart-img">
				<img
					src="${pageContext.request.contextPath}/resources/images/product/pink_heart.png"
					width="28px" /> <br /> <span>1,562</span>
			</div>
			<div>
				<button class="btn btn1">장바구니</button>
				<button class="btn btn2">구매하기</button>
			</div>
		</div>
	</div>
</section>
<script>
// 리뷰 페이지 아코디언 효과
const ques = document.querySelectorAll(".que");
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
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />