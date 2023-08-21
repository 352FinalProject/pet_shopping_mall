<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">주문 조회</h1>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/admin.do">관리자 홈</a></li>
			</ol>
			<div class="card mb-4">
				<div class="card-body">
					김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원김대원
				</div>
			</div>
			
			<div class="admin-order-search-container">
			    <form method="GET" class="admin-order-search" action="${pageContext.request.contextPath}/admin/adminOrderSearch.do">
			        <label for="searchKeyword">검색어:</label>
			        <select name="searchCategory">
			            <option value="productName">상품명</option>
			            <option value="productCode">주문코드</option>
			        </select>
			        <input type="text" id="searchKeyword" name="searchKeyword" placeholder="상품명 또는 주문코드"><br>
			        기간검색: <input type="date" name="startDate">
			    	~ <input type="date" name="endDate">
			    	<br>
			        <label>결제방법:</label>
				    <input type="checkbox" id="all" name="paymentMethod" value="all">
				    <label for="all">전체</label>
				    <input type="checkbox" id="mutongjang" name="paymentMethod" value="mutongjang">
				    <label for="mutongjang">무통장</label>
				    <input type="checkbox" id="sinhancard" name="paymentMethod" value="sinhancard">
				    <label for="sinhancard">신용카드</label>
			        <br>
			        <label>주문상태:</label>
				    <input type="checkbox" id="orderStatusAll" name="orderStatus" value="orderStatusAll">
				    <label for="orderStatusAll">전체</label>
				    <input type="checkbox" id="waiting" name="orderStatus" value="waiting">
				    <label for="waiting">입금대기</label>
				    <input type="checkbox" id="completeDeposit" name="orderStatus" value="completeDeposit">
				    <label for="completeDeposit">입금완료</label>
				    <input type="checkbox" id="readyDelivery" name="orderStatus" value="readyDelivery">
				    <label for="readyDelivery">배송준비</label>
				    <input type="checkbox" id="delivering" name="orderStatus" value="delivering">
				    <label for="delivering">배송중</label>
				    <input type="checkbox" id="delivered" name="orderStatus" value="delivered">
				    <label for="delivered">배송완료</label>
				    <input type="checkbox" id="canceled" name="orderStatus" value="canceled">
				    <label for="canceled">취소</label>
				    <input type="checkbox" id="refunded" name="orderStatus" value="refunded">
				    <label for="refunded">환불</label>
			        <br>
			        <button type="submit">검색</button>
			    </form>
			</div>
			
			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-table me-1"></i> 주문목록
				</div>
				<div class="card-body">
					<table id="datatablesSimple">
						<thead>
							<tr>
								<th>번호</th>
								<th>주문일시</th>
								<th>주문번호</th>
								<th>주문상품</th>
								<th>주문상태</th>
								<th>결제상태</th>
								<th>주문자</th>
								<th>결제액</th>
								<th>배송비</th>
								<th>결제방법</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${orderlists}" var="orderlist" varStatus="vs">
								<tr>
									<td>${orderlist.orderId}</td>
									<td>${orderlist.orderDate}</td>
									<td>${orderlist.orderNo}</td>
									<td>${orderlist.productName}</td>
									<td>
										<c:if test="${orderlist.orderStatus == 0}">
											입금대기
										</c:if>
										<c:if test="${orderlist.orderStatus == 1}">
											입금완료
										</c:if>
										<c:if test="${orderlist.orderStatus == 2}">
											배송준비
										</c:if>
										<c:if test="${orderlist.orderStatus == 3}">
											배송중
										</c:if>
										<c:if test="${orderlist.orderStatus == 4}">
											배송완료
										</c:if>
										<c:if test="${orderlist.orderStatus == 5}">
											주문취소
										</c:if>
										<c:if test="${orderlist.orderStatus == 6}">
											환불
										</c:if>
										<c:if test="${orderlist.orderStatus == 7}">
											반품
										</c:if>
									</td>
									<td>
										<c:if test="${orderlist.paymentState == 0}">
											결제 전
										</c:if>
										<c:if test="${orderlist.paymentState == 1}">
											결제 완료
										</c:if>
									</td>
									<td>${orderlist.memberId}</td>
									<td>${orderlist.amount}</td>
									<td>${orderlist.deliveryFee}</td>
									<td>
										<c:if test="${orderlist.paymentMethod == 0}">
											무통장입금
										</c:if>
										<c:if test="${orderlist.paymentMethod == 1}">
											카드결제
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>