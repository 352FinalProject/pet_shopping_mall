<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>

<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h2 class="mt-3">주문 조회</h2>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"></li>
			</ol>
			<div class="card mb-4">
				<div class="card-body">
					<div class="admin-order-search-container">
			    <form:form 
			    	method="GET" 
			    	name="adminOrderSearch"
			    	action="${pageContext.request.contextPath}/admin/adminOrderSearch.do">
			        
			        <input type="text" id="searchKeyword" name="searchKeyword" placeholder="상품명 또는 주문코드" class="adminSearch"><br>
			        <div class="adminDateSearch-info">
			        	<input type="date" name="startDate" class="adminDateSearch"> &nbsp; ~ &nbsp; <input type="date" name="endDate" class="adminDateSearch">
			    	</div>
			    	
					<label for="all" class="btn btn-secondary">전체 결제방법
				    	<input type="checkbox" id="paymentMethodAll" name="paymentMethod" value="all" onclick="selectAllpaymentMethod(this)">
					</label>
				    
				    <label for="deposit" class="btn btn-secondary">신용카드
				    	<input type="checkbox" id="deposit" name="paymentMethod" value="0">
				    </label>
				    
				    <label for="creditcard" class="btn btn-secondary">카카오페이
				    	<input type="checkbox" id="creditcard" name="paymentMethod" value="1">
				    </label>
			        <br>
			        
				    <input type="checkbox" id="orderStatusAll" name="orderStatus" value="orderStatusAll" onclick="selectAllOrderStatus(this)">
				    <label for="orderStatusAll">전체 주문상태</label>
				    <input type="checkbox" id="waiting" name="orderStatus" value="0">
				    <label for="waiting">결제완료</label>
				    <input type="checkbox" id="completeDeposit" name="orderStatus" value="1">
				    <label for="completePayment">배송준비</label>
				    <input type="checkbox" id="readyDelivery" name="orderStatus" value="2">
				    <label for="readyDelivery">배송중</label>
				    <input type="checkbox" id="delivering" name="orderStatus" value="3">
				    <label for="delivering">배송완료</label>
				    <input type="checkbox" id="delivered" name="orderStatus" value="4">
				    <label for="delivered">주문취소</label>
				    <input type="checkbox" id="canceled" name="orderStatus" value="5">
				    <label for="canceled">환불완료</label>
				    <input type="checkbox" id="refunded" name="orderStatus" value="6">
				    <label for="refunded">구매확정</label>
			        <br>
			        
			        <button type="submit" class="btn btn-secondary">검색</button>
			    </form:form>
			</div>
				</div>
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
								<th>주문자</th>
								<th>결제액</th>
								<th>배송비</th>
								<th>결제방법</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${orderlists}" var="orderlist" varStatus="vs">
								<tr>
									<td>${vs.count}</td>
									<td>${orderlist.orderDate}</td>
									<td>${orderlist.orderNo}</td>
									<td>${orderlist.productName}</td>
									<td>
										<c:if test="${orderlist.orderStatus == 0}">
											결제완료
										</c:if>
										<c:if test="${orderlist.orderStatus == 1}">
											배송준비
										</c:if>
										<c:if test="${orderlist.orderStatus == 2}">
											배송중
										</c:if>
										<c:if test="${orderlist.orderStatus == 3}">
											배송완료
										</c:if>
										<c:if test="${orderlist.orderStatus == 4}">
											주문취소
										</c:if>
										<c:if test="${orderlist.orderStatus == 5}">
											환불완료
										</c:if>
										<c:if test="${orderlist.orderStatus == 6}">
											구매확정
										</c:if>
									</td>
									<td>${orderlist.memberId}</td>
									<td>${orderlist.amount}</td>
									<td>${orderlist.deliveryFee}</td>
									<td>
										<c:if test="${orderlist.paymentMethod == 1}">
											카카오페이
										</c:if>
										<c:if test="${orderlist.paymentMethod == 0}">
											신용카드
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
<script>
    function selectAllpaymentMethod(selectAll) {
      const checkboxes = document.getElementsByName('paymentMethod');
      
      checkboxes.forEach((checkbox) => {
        checkbox.checked = selectAll.checked; // Use the selectAll argument here
      });
    }
    
    function selectAllOrderStatus(selectAll) {
        const orderStatusCheckboxes = document.getElementsByName('orderStatus');
        
        orderStatusCheckboxes.forEach((checkbox) => {
          checkbox.checked = selectAll.checked;
        });
      }
</script>
	<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>