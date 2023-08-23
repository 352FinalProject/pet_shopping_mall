<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">관리자 홈</h1>
					<ol class="breadcrumb mb-4">
					</ol>
					<div class="row">
						<div class="col-xl-3 col-md-6">
							<div class="card bg-primary text-white mb-4">
								<div class="card-body">주문 관리</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link" href="${pageContext.request.contextPath}/admin/adminOrderList.do">주문 조회</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card bg-warning text-white mb-4">
								<div class="card-body">상품 관리</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link" href="${pageContext.request.contextPath}/admin/adminProductList.do">상품 조회</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card bg-success text-white mb-4">
								<div class="card-body">회원 관리</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link" href="${pageContext.request.contextPath}/admin/adminMemberList.do">회원 조회</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card bg-danger text-white mb-4">
								<div class="card-body">매출 통계</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link" href="${pageContext.request.contextPath}/admin/adminStatistics.do">매출 관리</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-area me-1"></i> 일별 매출
								</div>
								<div class="card-body">
									<canvas id="myAreaChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-bar me-1"></i> 월별 매출
								</div>
								<div class="card-body">
									<canvas id="myBarChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
					</div>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> 최근 주문 목록
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
											결제대기
										</c:if>
										<c:if test="${orderlist.orderStatus == 1}">
											결제완료
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
									<td>${orderlist.memberId}</td>
									<td>${orderlist.amount}</td>
									<td>${orderlist.deliveryFee}</td>
									<td>
										<c:if test="${orderlist.paymentMethod == 0}">
											카카오페이
										</c:if>
										<c:if test="${orderlist.paymentMethod == 1}">
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
			
<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>