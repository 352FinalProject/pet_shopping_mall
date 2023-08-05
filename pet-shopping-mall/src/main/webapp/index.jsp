<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>
<div class="container">
  <div class="section section_1" id="section_1">
    <div class="swiper-container" id="my-swiper">
      <div class="swiper-wrapper">
        <div class="swiper-slide">
          <img src="${pageContext.request.contextPath}/resources/images/배너/0.배너.png" alt="홈 배경" />
        </div>
        <div class="swiper-slide">
          <img src="${pageContext.request.contextPath}/resources/images/배너/0.배너.png" alt="홈 배경3" />
        </div>
        <div class="swiper-slide">
          <img src="${pageContext.request.contextPath}/resources/images/배너/0.배너.png" alt="홈 배경4" />
        </div>
      </div>
      <div class="swiper-pagination1">
        <div class="swiper-pagination"></div>
      </div>
    </div>
  </div>
  <div class="section section_1_2" id="section_1_2">
    <h3 class="title"><a href="${pageContext.request.contextPath}/product/productList.do" ><span>사료</span></a></h2>
    <h3 class="title"><a href="${pageContext.request.contextPath}/product/productList.do" ><span>간식</span></a></h2>
    <h3 class="title"><a href="${pageContext.request.contextPath}/product/productList.do" ><span>용품</span></a></h2>
    <h3 class="sub_title"></h3>
    <div class="gallery_wrap">
      <ul class="gallery">
        <li>
          <a href="#">
            <img src="" class="indexImg"/>
            <div class="gallery_text">
            </div>
          </a>
        </li>
        <li>
          <a href="#">
            <img src="" class="indexImg"/>
            <div class="gallery_text">
            </div>
          </a>
        </li>
        <li>
          <a href="#">
            <img src="" class="indexImg"/>
            <div class="gallery_text">
            </div>
          </a>
        </li>
        <li>
          <a href="#">
            <img src="" class="indexImg"/>
            <div class="gallery_text">
            </div>
          </a>
        </li>
        <li>
          <a href="#">
            <img src="" class="indexImg"/>
            <div class="gallery_text">
            </div>
          </a>
        </li>
        <li>
          <a href="#">
            <img src="" class="indexImg"/>
            <div class="gallery_text">
            </div>
          </a>
        </li>
        <li>
          <a href="#">
            <img src=""  class="indexImg"/>
            <div class="gallery_text">
            </div>
          </a>
        </li>
      </ul>
    </div>
    <div class="button_box">
      <div class="prev_btn">
        <img
                src="/hairball/images/홈/left-arrow - 복사본.png"
                alt="이전"
        />
      </div>
      <div class="next_btn">
        <img
                src="/hairball/images/홈/right-arrow - 복사본.png"
                alt="다음"
        />
      </div>
    </div>
  </div>
</div>
<script>
document.addEventListener("DOMContentLoaded", function () {
	  const slide = new Swiper("#my-swiper", {
	    slidesPerView: "auto", // 한 슬라이드에 보여줄 갯수
	    // spaceBetween: 6, // 슬라이드 사이 여백
	    loop: false, // 슬라이드 반복 여부
	    loopAdditionalSlides: 1, // 슬라이드 반복 시 마지막 슬라이드에서 다음 슬라이드가 보여지지 않는 현상 수정
	    pagination: false, // pager 여부
	    autoplay: {
	      // 자동 슬라이드 설정 , 비 활성화 시 false
	      delay: 3000, // 시간 설정
	      disableOnInteraction: false, // false로 설정하면 스와이프 후 자동 재생이 비활성화 되지 않음
	    },
	    pagination: {
	      el: ".swiper-pagination",
	      clickable: true,
	    },
	  });
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>