<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/popup.jsp"></jsp:include>

<div class="container">
	<div class="section section_1" id="section_1">
		<div class="swiper-container" id="my-swiper">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<img
						src="${pageContext.request.contextPath}/resources/images/배너/0.배너.png"
						alt="홈 배경" />
				</div>
				<div class="swiper-slide">
					<img
						src="${pageContext.request.contextPath}/resources/images/배너/1.배너.png"
						alt="홈 배경3" />
				</div>
				<div class="swiper-slide">
					<img
						src="${pageContext.request.contextPath}/resources/images/배너/2.배너.png"
						alt="홈 배경4" />
				</div>
			</div>
			<div class="swiper-pagination1">
				<div class="swiper-pagination"></div>
			</div>
		</div>
	</div>
	<div class="section section_2" id="section_2">
		<div class="title_group">
			<div class="title_custom">
				<div class="title_desc">
					💪 털복숭이 친구들을 위한 영양간식 <a href="#"></a>
				</div>
				<a
					href="${pageContext.request.contextPath}/product/productList.do?categoryId=2">
					<div class="title_plus">
						더보기 <img
							src="${pageContext.request.contextPath}/resources/images/home/right-arrow.png"
							alt="홈 배경4" />
					</div>
				</a>
			</div>
			<div class="gallery_wrap2">
				<ul class="gallery2">
					<c:forEach items="${snackProductInfos}" var="productInfo" varStatus="vs">
						<div class="product-card">
							<a
								href="${pageContext.request.contextPath}/product/productDetail.do?productId=${productInfo.productId}&reviewId=${reviewId.reviewId}">
								<figure class="product-thumbnail">
									<img alt="썸네일이미지"
										src="${pageContext.request.contextPath}/resources/upload/product/${productInfo.thumbnail}">
								</figure>
								<div class="product-desc">
									<p class="product-name">${productInfo.productName}</p>
									<p class="product-price">
										<fmt:formatNumber value="${productInfo.productPrice}"
											pattern="#,###" />
										원
									</p>
									<span class="review-star"><img
										src="${pageContext.request.contextPath}/resources/images/상품/star.png"
										alt="별점"> <span>${productInfo.reviewStarRate}</span> </span> <span>
										&nbsp;|&nbsp; </span> <span class="review-cnt">후기
										${productInfo.reviewCnt}건</span>
								</div>
							</a>
						</div>
					</c:forEach>
				</ul>
			</div>
			<div class="button_box">
				<div class="prev_btn">
					<img
						src="${pageContext.request.contextPath}/resources/images/home/left-arrow.png"
						alt="이전" />
				</div>
				<div class="next_btn">
					<img
						src="${pageContext.request.contextPath}/resources/images/home/right-arrow.png"
						alt="다음" />
				</div>
			</div>
		</div>
		<div class="title_group">
			<div class="title_custom">
				<div class="title_desc">
					✨ 색다른 패션으로 개성을 뽐내세요! <a href="#"></a>
				</div>
				<a
					href="${pageContext.request.contextPath}/product/productList.do?categoryId=3">
					<div class="title_plus">
						더보기 <img
							src="${pageContext.request.contextPath}/resources/images/home/right-arrow.png"
							alt="홈 배경4" />
					</div>
				</a>
			</div>
			<div class="gallery_wrap3">
				<ul class="gallery3">
					<c:forEach items="${fashionProductInfos}" var="productInfo"
						varStatus="vs">
						<div class="product-card">
							<a
								href="${pageContext.request.contextPath}/product/productDetail.do?productId=${productInfo.productId}&reviewId=${reviewId.reviewId}">
								<figure class="product-thumbnail">
									<img alt="썸네일이미지"
										src="${pageContext.request.contextPath}/resources/upload/product/${productInfo.thumbnail}">
								</figure>
								<div class="product-desc">
									<p class="product-name">${productInfo.productName}</p>
									<p class="product-price">
										<fmt:formatNumber value="${productInfo.productPrice}"
											pattern="#,###" />
										원
									</p>
									<span class="review-star"><img
										src="${pageContext.request.contextPath}/resources/images/상품/star.png"
										alt="별점"> <span>${productInfo.reviewStarRate}</span> </span> <span>
										&nbsp;|&nbsp; </span> <span class="review-cnt">후기
										${productInfo.reviewCnt}건</span>
								</div>
							</a>
						</div>
					</c:forEach>
				</ul>
			</div>
			<div class="button_box">
				<div class="prev_btn">
					<img
						src="${pageContext.request.contextPath}/resources/images/home/left-arrow.png"
						alt="이전" />
				</div>
				<div class="next_btn">
					<img
						src="${pageContext.request.contextPath}/resources/images/home/right-arrow.png"
						alt="다음" />
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	/* 배너 슬라이드 */
	document.addEventListener("DOMContentLoaded", function() {
		const slide = new Swiper("#my-swiper", {
			slidesPerView : "auto", // 한 슬라이드에 보여줄 갯수
			// spaceBetween: 6, // 슬라이드 사이 여백
			loop : false, // 슬라이드 반복 여부
			loopAdditionalSlides : 1, // 슬라이드 반복 시 마지막 슬라이드에서 다음 슬라이드가 보여지지 않는 현상 수정
			pagination : false, // pager 여부
			autoplay : {
				// 자동 슬라이드 설정 , 비 활성화 시 false
				delay : 3000, // 시간 설정
				disableOnInteraction : false, // false로 설정하면 스와이프 후 자동 재생이 비활성화 되지 않음
			},
			pagination : {
				el : ".swiper-pagination",
				clickable : true,
			},
		});
	});

	/* 하단 슬라이드 2 */
	document.addEventListener("DOMContentLoaded", function() {
		let imgs = document.querySelector(".gallery2");
		createSlider(imgs);
	});

	/* 하단 슬라이드 3 */
	document.addEventListener("DOMContentLoaded", function() {
		let imgs = document.querySelector(".gallery3");
		createSlider(imgs);
	});

	function createSlider(imgs) {
		let img_count = imgs.childElementCount;
		let img_position = 0;

		imgs.parentNode.parentNode.querySelector(".prev_btn").addEventListener(
				"click", function(e) {
					back();
				});

		imgs.parentNode.parentNode.querySelector(".next_btn").addEventListener(
				"click", function(e) {
					if (img_position < img_count - 5) {
						next();
					} else {
						e.preventDefault();
					}
				});

		function back() {
			if (img_position > 0) {
				img_position--;
				imgs.style.transform = "translateX(" + (-img_position * 316)
						+ "px)";
			}
		}

		function next() {
			if (img_position < img_count - 5) {
				img_position++;
				imgs.style.transform = "translateX(" + (-img_position * 316)
						+ "px)";
			}
		}
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />