/* 대문 이미지 슬라이드 */
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