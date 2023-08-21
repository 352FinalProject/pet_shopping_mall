<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">상품별 매출</h1>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="index.html">상품별 매출</a></li>
				<li class="breadcrumb-item"><a href="index.html">날짜별 매출</a></li>
			</ol>
			<div class="card mb-4">
				<div class="card-body">
					Chart.js is a third party plugin that is used to generate the
					charts in this template. The charts below have been customized -
					for further customization options, please visit the official <a
						target="_blank" href="https://www.chartjs.org/docs/latest/">Chart.js
						documentation</a> .
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-chart-area me-1"></i> Area Chart Example
				</div>
				<div class="card-body">
					<canvas id="myAreaChart" width="100%" height="30"></canvas>
				</div>
				<div class="card-footer small text-muted">Updated yesterday at
					11:59 PM</div>
			</div>
			<div class="row">
				<div class="col-lg-6">
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-chart-bar me-1"></i> Bar Chart Example
						</div>
						<div class="card-body">
							<canvas id="myBarChart" width="100%" height="50"></canvas>
						</div>
						<div class="card-footer small text-muted">Updated yesterday
							at 11:59 PM</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>