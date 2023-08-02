<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<div class="container">
  <div class="section section_1" id="section_1">
    <div class="swiper-container" id="my-swiper">
      <div class="swiper-wrapper">
        <div class="swiper-slide">
          <img src="/hairball/images/홈/home_2.jpg" alt="홈 배경" />
        </div>
        <div class="swiper-slide">
          <img src="/hairball/images/홈/몽이2.jpg" alt="홈 배경3" />
        </div>
        <div class="swiper-slide">
          <img src="/hairball/images/홈/몽이1.jpg" alt="홈 배경4" />
        </div>
        <div class="swiper-slide">
          <img src="/hairball/images/홈/home_4.jpg" alt="홈 배경2" />
        </div>
      </div>
      <div class="swiper-pagination1">
        <div class="swiper-pagination"></div>
      </div>
    </div>
    <h2 class="title">
      혼자가 아닌 <span>함께</span>라서 <span>행복</span>한 순간
    </h2>
    <h3 class="sub_title">사랑스러운 아이들이 기다리고 있어요</h3>
    <div class="go_click">
      <a href="<%= request.getContextPath() %>/animal/list">
        <img src="/hairball/images/홈/만나러가기.png"
                alt="만나러 가기"
        />
      </a>
    </div>
  </div>
  <div class="section section_1_2" id="section_1_2">
    <h2 class="title"><span>#</span> 입양가능</h2>
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
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>