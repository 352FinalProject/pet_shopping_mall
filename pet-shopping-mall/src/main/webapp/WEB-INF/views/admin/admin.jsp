<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h2 class="mt-3">관리자 홈</h2>
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
									<a class="small text-white stretched-link" href="${pageContext.request.contextPath}/admin/adminStatisticsProduct.do">매출 관리</a>
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
									<i class="fas fa-chart-area me-1"></i> 날짜별 매출
								</div>
								<div class="card-body">
									<canvas id="myAreaChart-daily" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-bar me-1"></i> 상품별 매출
								</div>
								<div class="card-body">
									<canvas id="myBarChart-totalPrice" width="100%" height="40"></canvas>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script>
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

	var labelsPrice = [];
	var totalPrice = [];

	<c:forEach items="${priceStatistics}" var="priceStatistic" end="10">
		labelsPrice.push('${priceStatistic.productName}');
	    totalPrice.push(${priceStatistic.totalPrice});
	</c:forEach>
	
	var ctx = document.getElementById("myBarChart-totalPrice").getContext("2d");
	var myBarChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: labelsPrice,
	        datasets: [{
	            label: '매출액',
	            data: totalPrice,  // Use the correct variable name here
	            backgroundColor: 'rgba(135, 206, 235, 0.8)',
	            borderColor: 'rgba(0, 0, 0, 0.8)',
	            borderWidth: 2
	        }]
	    },
	    options: {
	        scales: {//x,y축 설정
				yAxes: [{
					ticks: {
						stepSize: 200000, //y축 간격
						suggestedMin: 0,//y축 최소 값
					},
					gridLines: {//y축 라인 스타일 설정
						borderDash: [2, 2],
						borderDashOffset: 0.2
					}
				}],
				xAxes: [{//x축 설정
					categoryPercentage: 1,
                	barPercentage: 0.5, 
					ticks: {
						
					}
				}]
	   		}
	    }
	});
	
	var labelsDaily = [];
	var dailyTotalSales = [];

	<c:forEach items="${dailyStatistics}" var="dailyStatistic" end="30">
		labelsDaily.push('${dailyStatistic.orderDaily}');
	    dailyTotalSales.push(${dailyStatistic.dailyTotalSales});
	</c:forEach>
	
	var ctx = document.getElementById("myAreaChart-daily").getContext("2d");
	var myBarChart = new Chart(ctx, {
	    type: 'line',
	    data: {
	        labels: labelsDaily,
	        datasets: [{
	            label: '일별',
	            data: dailyTotalSales,  // Use the correct variable name here
	            lineTension: 0.3,
				backgroundColor: "rgba(255, 255, 255, 0.2)",
				borderColor: "rgba(139, 0, 0, 0.8)",
				pointRadius: 5,
				pointBackgroundColor: "rgba(139, 0, 0, 0.8)",
				pointBorderColor: "rgba(255, 0, 0, 0.2)",
				pointHoverRadius: 5,
				pointHoverBackgroundColor: "rgba(139, 0, 0, 0.8)",
				pointHitRadius: 50,
				pointBorderWidth: 2,
	        }]
	    },
	    options: {
			scales: {
			xAxes: [{
				time: {
				unit: 'date'
				},
				gridLines: {
				display: false
				},
				ticks: {
				maxTicksLimit: 30
				}
			}],
			yAxes: [{
				ticks: {
				min: 0,
				maxTicksLimit: 5
				},
				gridLines: {
				color: "rgba(200, 200, 200, 0.5)",
				}
			}],
			},
			legend: {
			display: false
	   		}
		}
	});
</script>	
<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>