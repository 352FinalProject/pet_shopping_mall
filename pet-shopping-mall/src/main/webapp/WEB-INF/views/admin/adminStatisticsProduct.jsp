<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>

<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h2 class="mt-3">상품별 매출</h2>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"></li>
			</ol>
			
			<div class="card mb-4">
				<div class="card-body">
					상품별 판매순위 및 판매액 매출순위
				</div>
			</div>
			<div class="row">
				<div class="col-xl-6">
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-chart-bar me-1"></i> 매출액 순위
						</div>
						<div class="card-body">
							<canvas id="myBarChart-totalPrice" width="100%" height="40"></canvas>
						</div>
					</div>
				</div>
				<div class="col-xl-6">
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-chart-bar me-1"></i> 판매량 순위
						</div>
						<div class="card-body">
							<canvas id="myBarChart-totalSold" width="100%" height="40"></canvas>
						</div>
					</div>
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-table me-1"></i> 판매 순위
				</div>
				<div class="card-body">
					<table id="datatablesSimple">
						<thead>
							<tr>
								<th>순위</th>
								<th>상품코드</th>
								<th>상품명</th>
								<th>카테고리</th>
								<th>상품가격</th>
								<th>판매수량</th>
								<th>판매액</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${productStatistics}" var="productStatistic" varStatus="vs">
								<tr>
									<td>${vs.count}</td>
									<td>${productStatistic.productId}</td>
									<td>${productStatistic.productName}</td>
									<td>${productStatistic.categoryName}</td>
									<td>${productStatistic.productPrice}</td>
									<td>${productStatistic.totalSold}</td>
									<td>${productStatistic.totalPrice}</td>
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

	var labelsProduct = [];
	var labelsPrice = [];
	var totalSold = [];
	var totalPrice = [];

	<c:forEach items="${productStatistics}" var="productStatistic" end="10">
		labelsProduct.push('${productStatistic.productName}');
	    totalSold.push(${productStatistic.totalSold});
	</c:forEach>
	
	<c:forEach items="${priceStatistics}" var="priceStatistic" end="10">
		labelsPrice.push('${priceStatistic.productName}');
	    totalPrice.push(${priceStatistic.totalPrice});
	</c:forEach>
	
	var ctx = document.getElementById("myBarChart-totalSold").getContext("2d");
	var myBarChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: labelsProduct,
	        datasets: [{
	            label: '판매수량',
	            data: totalSold,  // Use the correct variable name here
	            backgroundColor: 'rgba(144, 238, 144, 0.8)',
	            borderColor: 'rgba(0, 0, 0, 0.8)',
	            borderWidth: 1.3
	        }]
	    },
	    options: {
	        scales: {//x,y축 설정
				yAxes: [{
					ticks: {
						stepSize: 20, //y축 간격
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
</script>	
<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>