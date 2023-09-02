<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>

<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h2 class="mt-3">날짜별 매출</h2>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"></li>
			</ol>
			<div class="card mb-4">
				<div class="card-body">
					일별 매출 월별 매출 통계입니다
				</div>
			</div>
			<div class="row">
				<div class="col-xl-6">
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-chart-area me-1"></i> 월별 매출
						</div>
						<div class="card-body">
							<canvas id="myAreaChart-montly" width="100%" height="40"></canvas>
						</div>
					</div>
				</div>
				<div class="col-xl-6">
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-chart-area me-1"></i> 일별 매출
						</div>
						<div class="card-body">
							<canvas id="myAreaChart-daily" width="100%" height="40"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script>
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

	var labelsDaily = [];
	var dailyTotalSales = [];
	var labelsMonthly = [];
	var monthlyTotalSales = [];

	<c:forEach items="${dailyStatistics}" var="dailyStatistic" end="30">
		labelsDaily.push('${dailyStatistic.orderDaily}');
	    dailyTotalSales.push(${dailyStatistic.dailyTotalSales});
	</c:forEach>
	
	<c:forEach items="${monthlyStatistics}" var="monthlyStatistic" end="12">
		labelsMonthly.push('${monthlyStatistic.orderMonthly}');
	    monthlyTotalSales.push(${monthlyStatistic.monthlyTotalSales});
	</c:forEach>
	
	var ctx = document.getElementById("myAreaChart-montly").getContext("2d");
	var myBarChart = new Chart(ctx, {
	    type: 'line',
	    data: {
	        labels: labelsMonthly,
	        datasets: [{
	            label: '월별',
	            data: monthlyTotalSales,  // Use the correct variable name here
	            lineTension: 0.3,
				backgroundColor: "rgba(255, 255, 255, 0.2)",
				borderColor: "rgba(2,117,216,1)",
				pointRadius: 5,
				pointBackgroundColor: "rgba(2,117,216,1)",
				pointBorderColor: "rgba(135, 206, 235, 0.8)",
				pointHoverRadius: 5,
				pointHoverBackgroundColor: "rgba(2,117,216,1)",
				pointHitRadius: 50,
				pointBorderWidth: 2,
	        }]
	    },
	    options: {
			scales: {
			xAxes: [{
				time: {
				unit: 'month'
				},
				gridLines: {
				display: false
				},
				ticks: {
				maxTicksLimit: 12
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