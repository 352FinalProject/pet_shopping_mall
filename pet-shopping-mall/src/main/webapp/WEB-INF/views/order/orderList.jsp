<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <style>
        .sub_title {
            font-size: 32px;
            font-weight: bold;
            text-align: center;
            line-height: 120px;
        }

        #selectPeriod {
            position: relative;
            outline: none;
            display: block;
            width: 150px;
            margin: 30px 0;
            font-size: 17px;
            color: #333;
            height: 40px;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            padding-right: 30px;
            padding-left: 10px;
            background: url('${pageContext.request.contextPath }/resources/images/상품/arrow-down.png') no-repeat 95% 50%/15px auto;
            border: 1px solid #999;
        }

        .order_top {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        a {
            color: #999;
            text-decoration: none;
        }

        table a {
            color: #333;
        }

        #order_table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }

        #order_table thead {
            width: 100%;
            height: 50px;
            border-top: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
        }

        #order_table tr td {
            height: 150px;
            border-bottom: 1px solid #ccc;
        }

        #order_table tr td:nth-child(1) {
            width: 15%;
        }

        #order_table tr td:nth-child(2) {
            width: 15%;
        }

        #order_table tr td:nth-child(3) {
            width: 40%;
        }

        #order_table tr td:nth-child(4) {
            width: 15%;
        }

        #order_table tr td:nth-child(5) {
            width: 15%;
        }

        #order_table img {
            width: 130px;
            height: 130px;
            margin: 10px;
            margin-right: 30px;
            margin-left: 50px;
        }

        #order_table button {
            border: 1px solid #ccc;
            color: #ccc;
            width: 80%;
            margin: 0 auto;
            height: 35px;
            font-size: 17px;
            background-color: #fff;
            cursor: pointer;
        }

        .flex div {
            height: 130px;
        }

        .flex p {
            margin: 0;
            margin-bottom: 5px;
        }

        .flex {
            margin-top: 10px;
            width: 100%;
            display: flex;
            align-items: center;
            text-align: left;
        }
	</style>
	<section class="common-section" id="#">
		<div class="common-title">주문내역</div>
		<div class="common-container">
			<div class="order">
				<div class="order_top">
					<select name="selectPeriod" id="selectPeriod">
						<option value="3">최근 3개월</option>
						<option value="6">최근 6개월</option>
						<option value="12">최근 12개월</option>
					</select> <a style="margin-bottom: 10px;" href="#">내가 쓴 상품 후기 ▶</a>
				</div>
				<table id="order_table">
					<thead>
						<tr>
							<th>날짜</th>
							<th>주문번호</th>
							<th>상품</th>
							<th>주문금액</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${not empty orderHistories}">
						<c:forEach items="${orderHistories}" var="order" varStatus="vs">
							<c:set var="index" value="${order.orderStatus}"/>
							<c:set var="option" value="${order.optionName}" />
							<c:set var="amount" value="${order.amount}" />
							<fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" var="formattedDate"/>
							<tr>
								<td>${formattedDate}</td>
								<td>
									<p>${order.orderNo}</p>
  									<c:choose>
										<c:when test="${index eq 0}">
										    <button onclick="cancelOrder('cancel');">취소신청</button>
										</c:when>
										<c:when test="${index ge 1 && index le 4}">
										    <button onclick="cancelOrder('refund');">취소/환불신청</button>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
									<form:form id="cancelFrm" action="" method="POST">
										<input type="hidden" name="orderNo" value="${order.orderNo}" />
										<input type="hidden" name="amount" value="${order.amount}" />
										<input type="hidden" name="isRefund" value="" />
									</form:form>
								</td>
								<td><a
									href="${pageContext.request.contextPath}/member/orderDetail.do">
										<div class="flex">
											<img
												src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg"
												alt="">
											<div>
												<p>${order.productName}</p>
												<br />
											<c:if test="${option eq null}">
												<p>선택된 옵션이 없습니다.</p>
											</c:if>
											<c:if test="${option ne null}">
												<p>${order.optionName} : ${order.optionValue}</p>
											</c:if>
												<p>수량: ${order.quantity}개</p>
											</div>
										</div>
								</a></td>
								<td>${order.amount}원</td>
								<td>
									<p>${status[index]}</p>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
			<c:if test="${empty orderHistories}">
				<div>조회된 주문 내역이 없습니다.</div>
			</c:if>
			</div>
		</div>
	</section>
	<script
  		src="https://code.jquery.com/jquery-3.3.1.min.js"
  		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  		crossorigin="anonymous"></script>
	<script>
	const cancelFrm = document.querySelector("#cancelFrm");
	const amount = Number(cancelFrm.amount.value);
	
	const cancelOrder = (text) => {
		if(text === 'cancel') {
			cancelFrm.isRefund.value="N";
			cancelFrm.action ="${pageContext.request.contextPath}/order/cancelOrder.do";
		} else {
 			$.ajax({
				url : "https://api.iamport.kr/payments/cancel",
				type : "POST",
				dataType: "json",
				contentType: "application/json",
				data : JSON.stringify({
					merchant_uid: cancelFrm.orderNo.value,
					cancel_request_amount: amount
				}),
				success(response) {
					if(response.code == 200) {
						alert("환불이 정상적으로 처리되었습니다.");
						cancelFrm.isRefund.value="Y";
						cancelFrm.action ="${pageContext.request.contextPath}/order/cancelOrder.do";
						cancelFrm.submit();
					} else {
						alert("환불 실패! 관리자에게 문의하세요.")
					}
				}
			});
		}
	};

	/* 셀렉트 박스 */
	const periodSelect = document.querySelector("#selectPeriod");
	periodSelect.addEventListener('change', handleSelectChange);
	
	const handleSelectChange = () => {
		const selectedValue = selectBox.value;
		
		$.ajax({
			url: "${pageContext.request.}"
			method: "GET",
		})
	}
	</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>