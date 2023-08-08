<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
    <section class="common-section" id="#">
        <div class="common-title">
         	1:1 문의 내역
        </div>
        <div class="common-container">
            <div class="common-div">
            	<div class="service-search">
	            	<img src="${pageContext.request.contextPath}/resources/images/home/search.png"alt="">
	                <input type="text" name="service-search" id="service-search" value="" placeholder="제목, 내용" required>
	            </div>
	            <form action="${pageContext.request.contextPath}/servicecenter/questionCreate.do" class="form-inline">
					<button class="btn-add" >1:1문의 쓰기</button>
				</form>
	        	<div class="service-util-div">
					<ul class="service-product-utility">
						<li class="qna-list-no"><a href="#">번호</a></li>
						<li class="qna-list-status"><a href="#">상태</a></li>
						<li class="qna-list-title"><a href="#">제목</a></li>
						<li class="qna-list-date"><a href="#">등록일</a></li>
					</ul>
				</div>
			<div class="accordion_wrap" id="accordion_wrap">
				<div class="que">
					<div class="qna-no">
						<ul>
							<li>1</li>
						</ul>
					</div>
					<div class="qna-state">
						<ul>
							<li class="qna-status">답변완료</li>
						</ul>
					</div>
					<div class="qna">
						<ul>
							<li class="qna-title">우동친이 머애요?</li>
						</ul>
					</div>
					<div class="qna-data-wrap">
						<ul>
							<li class="qna-date">23.08.06</li>
						</ul>
					</div>
				</div>
				<div class="anw">
					<div class="qna-desc"><span>Q</span> 우동친이 먼가요</div>
					<div class="anw-desc"><span>A</span> 우동친은 우리집동물친구의 줄임말입니다~</div>
				</div>
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