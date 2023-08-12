<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
section.order-header {
	display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 0;
    border-bottom: 1px solid #e7e7e7;
}
section.order-header .order-title {
    text-align: center;
    font-size: 30px;
    padding-top: 40px;
    padding-bottom: 30px;
}
div.order-detail img{
	object-fit: scale-down;
}
.detail-section, .detail-section * {
	box-sizing: border-box;
} 
.leftcolumn {
	float: left;
	width: 50%;
}
.rightcolumn {
  float: left;
  width: 50%;
}
.info-card {
  background-color: #e7e7e7;;
  padding: 20px;
  margin-top: 20px;
}
.info-head h3{
    display: inline-block;
	font-size: 20px;
    line-height: 20px;
    white-space: nowrap;
}
.info-content {
    word-wrap: break-word;
}
.info-content ul{
    display: block;
    list-style-type: none;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
}
.info-content li{
	position: relative;
    min-height: 19px;
    padding-left: 100px;
    line-height: 19px;
}
.info-content li strong{
    position: absolute;
    left: 0;
    top: 0;
    overflow: hidden;
    width: 100px;
    margin-left: 0px;
    white-space: nowrap;
    text-overflow: ellipsis;
    color: #8f8f8f
}
.info-content li span{
    display: inline-block;
    vertical-align: top;
}
.info-list {

}
/* Clear floats after the columns */
.order-wrapper:after {
  content: "";
  display: table;
  clear: both;
}
/* Responsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 800px) {
  .leftcolumn, .rightcolumn {
    width: 100%;
    padding: 0;
  }
}
.button-area {
    display: flex;
    justify-content: center;
}
.button-area button {
	font-size: 17px;
    line-height: 46px;
    color: #424242;
    background-color: #fff;
	text-align: center;
}
</style>
<div class="common-section">
	<!-- 컨테이너 -->
	<div class="common-container">
	<!-- 주문 헤더 -->
	<section class="order-header">
		<div class="order-title">주문취소</div>
	</section>
	
	<!-- 주문 바디 -->
	<section class="detail-section">
	<!-- 왼쪽칸 -->
	<div class="leftcolumn">
		<div class="info-card">
			<div class="info-head">
				<h3>주문자</h3>
			</div>
			<div class="info-content">
				<ul class="info-list">
					<li>
						<span>전예라</span>
					</li>
					<li>
						<span>010-1234-5678</span>
					</li>
				</ul>
			</div>
		</div>
		<div class="info-card">
			<div class="info-head">
				<h3>배송지</h3>
			</div>
			<div class="info-content">
				<ul class="info-list">
					<li>
						<span>전예라</span>
					</li>
					<li>
						<span>010-1234-5678</span>
					</li>
					<li>
						<span>서울시 강남구 역삼동 kh정보교육원</span>
					</li>
				</ul>
			</div>
		</div>
		<div class="info-card">
			<div class="info-head">
				<h3>주문결제정보</h3>
			</div>
			<div class="info-content">
				<ul class="info-list">
					<li>
						<strong>주문번호</strong>
						<span>123123123123</span>
					</li>
					<li>
						<strong>주문날짜</strong>
						<span>123123123123</span>
					</li>
					<li>
						<strong>결제일시</strong>
						<span>123123123123</span>
					</li>
					<li>
						<strong>결제수단</strong>
						<span>카드결제</span>
					</li>
					<li>
						<strong>결제금액</strong>
						<span>7,950원</span>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- 오른쪽 칸 -->
	<div class="rightcolumn">
		<div class="info-card">
			<div class="info-head">
				<h3>결제금액</h3>
			</div>
			<div class="info-content">
				<ul class="info-list">
					<li>
						<strong>주문번호</strong>
						<span>123123123123</span>
					</li>
					<li>
						<strong>주문날짜</strong>
						<span>123123123123</span>
					</li>
					<li>
						<strong>결제일시</strong>
						<span>123123123123</span>
					</li>
					<li>
						<strong>결제수단</strong>
						<span>카드결제</span>
					</li>
					<li>
						<strong>결제금액</strong>
						<span>7,950원</span>
					</li>
				</ul>
			</div>
		</div>
		<div class="info-card">
			<div class="button-area">
				<button type="button">
					<span>주문취소</span>
				</button>
			</div>
		</div>
	</div>
	
		
	</section>

	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>