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
.client { grid-area: client; }
.address-info { grid-area: address-info; }
.delivery-state { grid-area: delivery-state; }
.total-price { grid-area: total-price; }
.payment-info { grid-area: payment-info; }
section.order-wrapper {
	grid-template-areas:
        'client total-price'
        'address-info total-price'
        'delivery-state payment-info';
    display: grid;
    justify-content: space-around;
    gap: 0px;
    padding: 0;
    width: 100%;
    min-height: 40vw;
    background-color: beige;
    align-content: space-around;
    align-items: stretch;
    justify-items: center;
}
section.order-wrapper > div{
    min-height: 100px;
    min-width: 20em;
    width: 100%;
    background-color: white;
}
div.order-detail img{
	object-fit: scale-down;
}


</style>
<div class="common-section">
	<!-- 컨테이너 -->
	<div class="common-container">
	<!-- 주문 헤더 -->
	<section class="order-header">
		<div class="order-title">주문취소</div>
	
	<!-- 주문 바디 -->
	<section class="order-wrapper">
		<!-- 주문자 -->
		<div class="client">
			<div class="title">주문자</div>
		</div>
		
		<div class="address-info">
			<div class="title">배송지</div>
		</div>
		
		<div class="delivery-state">
			<div class="title">배송현황</div>
		</div>
		
		<div class="total-price">
			<div class="title">결제금액</div>
		</div>
		
		<div class="payment-info">
			<div class="title">주문결제정보</div>
		</div>
		
	</section>

	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>