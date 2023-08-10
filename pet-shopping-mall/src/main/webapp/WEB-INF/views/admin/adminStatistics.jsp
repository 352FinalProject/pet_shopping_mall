<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<h1>Daily Order Statistics</h1>
    <canvas id="dailyChart" width="400" height="200"></canvas>

    <h1>Monthly Order Statistics</h1>
    <canvas id="monthlyChart" width="400" height="200"></canvas>

    <script>
        // Sample data for daily order statistics
        var dailyLabels = ['2023-08-01', '2023-08-02', '2023-08-03', '2023-08-04']; // Add more labels
        var dailyData = [500, 800, 600, 1000]; // Add more data

        // Sample data for monthly order statistics
        var monthlyLabels = ['2023-08', '2023-09', '2023-10']; // Add more labels
        var monthlyData = [1500, 1800, 1200]; // Add more data

        // Create daily chart
        var dailyCtx = document.getElementById('dailyChart').getContext('2d');
        new Chart(dailyCtx, {
            type: 'bar',
            data: {
                labels: dailyLabels,
                datasets: [{
                    label: 'Total Amount',
                    data: dailyData,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            }
        });

        // Create monthly chart
        var monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
        new Chart(monthlyCtx, {
            type: 'bar',
            data: {
                labels: monthlyLabels,
                datasets: [{
                    label: 'Total Amount',
                    data: monthlyData,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            }
        });
    </script>




















<jsp:include page="/WEB-INF/views/common/footer.jsp" />